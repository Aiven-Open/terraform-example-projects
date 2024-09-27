# Create an Aiven for Apache Flink® service.
resource "aiven_flink" "example_flink" {
  project      = var.aiven_project_name
  cloud_name   = "google-europe-west1"
  plan         = "business-8"
  service_name = "example-flink"
}

# Create an Aiven for Apache Kafka® service.
resource "aiven_kafka" "example_kafka" {
  project      = var.aiven_project_name
  cloud_name   = "google-europe-west1"
  plan         = "business-8"
  service_name = "example-kafka"
}

# Create Kafka topics for the source and sink.
resource "aiven_kafka_topic" "source" {
  project      = var.aiven_project_name
  service_name = aiven_kafka.example_kafka.service_name
  partitions   = 2
  replication  = 3
  topic_name   = "cpu_measurements"
}

resource "aiven_kafka_topic" "sink" {
  project      = var.aiven_project_name
  service_name = aiven_kafka.example_kafka.service_name
  partitions   = 2
  replication  = 3
  topic_name   = "cpu_high_usage"
}

# Integrate the Kafka and Flink services.
resource "aiven_service_integration" "flink_to_kafka" {
  project                  = var.aiven_project_name
  integration_type         = "flink"
  destination_service_name = aiven_flink.example_flink.service_name
  source_service_name      = aiven_kafka.example_kafka.service_name
}

# Create a Flink application.
resource "aiven_flink_application" "example_app" {
  project      = var.aiven_project_name
  service_name = aiven_flink.example_flink.service_name
  name         = "example-app"
}

resource "aiven_flink_application_version" "example_app_version" {
  project        = var.aiven_project_name
  service_name   = aiven_flink.example_flink.service_name
  application_id = aiven_flink_application.example_app.application_id
  statement      = <<EOT
  INSERT INTO cpu_high_usage_table SELECT * FROM cpu_measurements_table WHERE usage > 85
  EOT
  sink {
    create_table   = <<EOT
      CREATE TABLE cpu_high_usage_table (
          time_ltz TIMESTAMP(3),
          hostname STRING,
          cpu STRING,
          usage DOUBLE
      ) WITH (
          'connector' = 'kafka',
          'properties.bootstrap.servers' = '',
          'scan.startup.mode' = 'earliest-offset',
          'topic' = 'cpu_high_usage',
          'value.format' = 'json'
      )
      EOT
    integration_id = aiven_service_integration.flink_to_kafka.integration_id
  }
  source {
    create_table   = <<EOT
      CREATE TABLE cpu_measurements_table (
          time_ltz TIMESTAMP(3),
          hostname STRING,
          cpu STRING,
          usage DOUBLE
      ) WITH (
          'connector' = 'kafka',
          'properties.bootstrap.servers' = '',
          'scan.startup.mode' = 'earliest-offset',
          'topic' = 'cpu_measurements',
          'value.format' = 'json'
      )
      EOT
    integration_id = aiven_service_integration.flink_to_kafka.integration_id
  }
}

resource "aiven_flink_application_deployment" "main" {
  project        = var.aiven_project_name
  service_name   = aiven_flink.example_flink.service_name
  application_id = aiven_flink_application.example_app.application_id
  version_id     = aiven_flink_application_version.example_app_version.application_version_id
}