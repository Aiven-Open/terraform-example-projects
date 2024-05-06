# Create a ClickHouse service.
resource "aiven_clickhouse" "example_clickhouse" {
  project                 = aiven_project.clickhouse_kafka_source.project
  cloud_name              = "google-europe-west1"
  plan                    = "startup-16"
  service_name            = "example-clickhouse"
  maintenance_window_dow  = "monday"
  maintenance_window_time = "10:00:00"
}

# Create an integration between the ClickHouse and Kafka services and add
# a database for the source topic containing edge measurements in JSON format.
resource "aiven_service_integration" "clickhouse_kafka_integration" {
  project                  = aiven_project.clickhouse_kafka_source.project
  integration_type         = "clickhouse_kafka"
  source_service_name      = aiven_kafka.example_kafka.service_name
  destination_service_name = aiven_clickhouse.example_clickhouse.service_name
  clickhouse_kafka_user_config {
    tables {
      name        = "edge_measurements_raw"
      group_name  = "clickhouse-ingestion"
      data_format = "JSONEachRow"
      columns {
        name = "sensor_id"
        type = "UInt64"
      }
      columns {
        name = "ts"
        type = "DateTime64(6)"
      }
      columns {
        name = "key"
        type = "LowCardinality(String)"
      }
      columns {
        name = "value"
        type = "Float64"
      }
      topics {
        name = aiven_kafka_topic.edge_measurements.topic_name
      }
    }
  }
}

# ClickHouse database that can be used to run analytics over the ingested data
resource "aiven_clickhouse_database" "iot_analytics" {
  project      = aiven_project.clickhouse_kafka_source.project
  service_name = aiven_clickhouse.example_clickhouse.service_name
  name         = "iot_analytics"
}
