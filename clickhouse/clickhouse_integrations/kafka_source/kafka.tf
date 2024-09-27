# Create a Kafka service.
resource "aiven_kafka" "example_kafka" {
  project                 = aiven_project.clickhouse_kafka_source.project
  cloud_name              = "google-europe-west1"
  plan                    = "business-4"
  service_name            = "example-kafka"
  maintenance_window_dow  = "monday"
  maintenance_window_time = "10:00:00"

  # Enable the Kafka REST API to view and send messages from the Console.
  kafka_user_config {
    kafka_rest = true

    public_access {
      kafka_rest = true
    }
  }
}

# Create a Kafka topic to ingest edge measurements from the IoT devices.
resource "aiven_kafka_topic" "edge_measurements" {
  project                = aiven_project.clickhouse_kafka_source.project
  service_name           = aiven_kafka.example_kafka.service_name
  topic_name             = "edge-measurements"
  partitions             = 50
  replication            = 3
  termination_protection = false

  config {
    flush_ms        = 10
    cleanup_policy  = "delete"
    retention_bytes = "134217728" # 10 GiB
    retention_ms    = "604800000" # 1 week
  }
}
