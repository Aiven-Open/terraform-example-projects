# Create a ClickHouse service.
resource "aiven_clickhouse" "example_clickhouse" {
  project                 = var.aiven_project_name
  cloud_name              = "google-europe-west1"
  plan                    = "hobbyist"
  service_name            = "clickhouse-gcp-eu"
  maintenance_window_dow  = "monday"
  maintenance_window_time = "10:00:00"
}

# Create a ClickHouse database to write the IoT data to.
resource "aiven_clickhouse_database" "iot_analytics" {
  project      = aiven_clickhouse.example_clickhouse.project
  service_name = aiven_clickhouse.example_clickhouse.service_name
  name         = "iot_analytics"
}

# Create the ETL user.
resource "aiven_clickhouse_user" "etl" {
  project      = aiven_clickhouse.example_clickhouse.project
  service_name = aiven_clickhouse.example_clickhouse.service_name
  username     = "etl"
}

# Create the writer role with insert privileges to the measurements database.
resource "aiven_clickhouse_role" "writer" {
  project      = aiven_clickhouse.example_clickhouse.project
  service_name = aiven_clickhouse.example_clickhouse.service_name
  role         = "writer"
}

resource "aiven_clickhouse_grant" "writer_role" {
  project      = aiven_clickhouse.example_clickhouse.project
  service_name = aiven_clickhouse.example_clickhouse.service_name
  role         = aiven_clickhouse_role.writer.role

  privilege_grant {
    privilege = "INSERT"
    database  = aiven_clickhouse_database.iot_analytics.name
  }

  privilege_grant {
    privilege = "SELECT"
    database  = aiven_clickhouse_database.iot_analytics.name
  }
}

# Grant the writer role to the ETL user.
resource "aiven_clickhouse_grant" "etl_user_role" {
  project      = aiven_clickhouse.example_clickhouse.project
  service_name = aiven_clickhouse.example_clickhouse.service_name
  user         = aiven_clickhouse_user.etl.username

  role_grant {
    role = aiven_clickhouse_role.writer.role
  }
}

# Create the analyst user.
resource "aiven_clickhouse_user" "analyst" {
  project      = var.aiven_project_name
  service_name = aiven_clickhouse.example_clickhouse.service_name
  username     = "analyst"
}

# Create the reader role with read-only access to the IoT measurements database.
resource "aiven_clickhouse_role" "reader" {
  project      = var.aiven_project_name
  service_name = aiven_clickhouse.example_clickhouse.service_name
  role         = "reader"
}

resource "aiven_clickhouse_grant" "reader_role" {
  project      = aiven_clickhouse.example_clickhouse.project
  service_name = aiven_clickhouse.example_clickhouse.service_name
  role         = aiven_clickhouse_role.reader.role

  privilege_grant {
    privilege = "SELECT"
    database  = aiven_clickhouse_database.iot_analytics.name
  }
}

# Grant the reader role to the analyst user.
resource "aiven_clickhouse_grant" "analyst_user" {
  project      = aiven_clickhouse.example_clickhouse.project
  service_name = aiven_clickhouse.example_clickhouse.service_name
  user         = aiven_clickhouse_user.analyst.username

  role_grant {
    role = aiven_clickhouse_role.reader.role
  }
}