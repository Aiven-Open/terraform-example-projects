# MySQL service based in GCP US East
resource "aiven_mysql" "external_mysql" {
  project      = aiven_project.clickhouse_managed_credentials_demo
  service_name = "external-mysql-gcp-us"
  cloud_name   = "google-us-east4"
  plan         = "business-8"
}

resource "aiven_service_integration_endpoint" "external_mysql" {
  project       = aiven_project.clickhouse_managed_credentials_demo
  endpoint_name = "external-mysql"
  endpoint_type = "external_mysql"

  external_mysql_user_config {
    host     = aiven_mysql.external_mysql.service_host
    port     = aiven_mysql.external_mysql.service_port
    username = aiven_mysql.external_mysql.service_username
    password = aiven_mysql.external_mysql.service_password
  }
}

