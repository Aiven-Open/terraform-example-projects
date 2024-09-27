# Postgres service based in GCP US East
resource "aiven_pg" "external_postgres" {
  project      = aiven_project.clickhouse_managed_credentials_demo
  service_name = "external-postgres-gcp-us"
  cloud_name   = "google-us-east4"
  plan         = "business-8" # Primary and read replica
}

resource "aiven_service_integration_endpoint" "external_postgres" {
  project       = aiven_project.clickhouse_managed_credentials_demo
  endpoint_name = "external-postgresql"
  endpoint_type = "external_postgresql"

  external_postgresql {
    host     = aiven_pg.external_postgres.service_host
    port     = aiven_pg.external_postgres.service_port
    username = aiven_pg.external_postgres.service_username
    password = aiven_pg.external_postgres.service_password
  }
}

