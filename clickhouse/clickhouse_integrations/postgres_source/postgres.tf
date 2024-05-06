# Create a Postgres service. 
resource "aiven_pg" "example_postgres" {
  project                 = aiven_project.clickhouse_postgres_source.project
  service_name            = "example-postgres"
  cloud_name              = "google-us-east4"
  plan                    = "business-8"
  maintenance_window_dow  = "monday"
  maintenance_window_time = "10:00:00"
}

# Create the databases.
resource "aiven_pg_database" "suppliers_dims" {
  project       = aiven_project.clickhouse_postgres_source.project
  service_name  = aiven_pg.example_postgres.service_name
  database_name = "suppliers_dims"
}

resource "aiven_pg_database" "inventory_facts" {
  project       = aiven_project.clickhouse_postgres_source.project
  service_name  = aiven_pg.example_postgres.service_name
  database_name = "inventory_facts"
}

resource "aiven_pg_database" "order_events" {
  project       = aiven_project.clickhouse_postgres_source.project
  service_name  = aiven_pg.example_postgres.service_name
  database_name = "order_events"
}
