# Your Aiven project.
data "aiven_project" "main" {
  project = "PROJECT_NAME"
}

# Add a Datadog integration endpoint. 
resource "aiven_service_integration_endpoint" "datadog" {
  project       = data.aiven_project.main.project
  endpoint_name = "Datadog"
  endpoint_type = "datadog"

  datadog_user_config {
    datadog_api_key = var.datadog_api_key
    datadog_tags {
      tag = "env:test"
    }
    site = var.datadog_site
  }
}

# Create an Aiven for Apache Kafka® service.
resource "aiven_kafka" "example_kafka" {
  project      = data.aiven_project.main.project
  cloud_name   = "google-europe-west1"
  plan         = "business-4"
  service_name = "kafka-datadog-integration-example"
}

# Integrate Datadog with the Kafka service.
resource "aiven_service_integration" "kafka_datadog_metrics" {
  project                 = data.aiven_project.main.project
  destination_endpoint_id = aiven_service_integration_endpoint.datadog.id
  integration_type        = "datadog"
  source_service_name     = aiven_kafka.example_kafka.service_name
}
