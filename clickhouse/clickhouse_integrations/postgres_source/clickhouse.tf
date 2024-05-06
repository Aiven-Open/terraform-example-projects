# Create a ClickHouse service based in the same region as the Postgres service.
resource "aiven_clickhouse" "example_clickhouse" {
  project                 = aiven_project.clickhouse_postgres_source.project
  service_name            = "example-clickhouse"
  cloud_name              = "google-us-east4"
  plan                    = "startup-16"
  maintenance_window_dow  = "monday"
  maintenance_window_time = "10:00:00"

}

# Create a service integration to ClickHouse with PostgreSQL as the source
# exposing the three databases in the public schema.
resource "aiven_service_integration" "clickhouse_postgres_source" {
  project                  = aiven_project.clickhouse_postgres_source.project
  integration_type         = "clickhouse_postgresql"
  source_service_name      = aiven_pg.example_postgres.service_name
  destination_service_name = aiven_clickhouse.example_clickhouse.service_name
  clickhouse_postgresql_user_config {
    databases {
      database = aiven_pg_database.suppliers_dims.database_name
      schema   = "public"
    }
    databases {
      database = aiven_pg_database.inventory_facts.database_name
      schema   = "public"
    }
    databases {
      database = aiven_pg_database.order_events.database_name
      schema   = "public"
    }
  }
}
