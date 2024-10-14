# Create an Aiven project.
resource "aiven_project" "example_project" {
  project = "example-static-ip-project"
}

# Create six static IP addresses.
resource "aiven_static_ip" "ips" {
  count = 6

  project    = aiven_project.example_project.project
  cloud_name = "google-europe-west1"
}

# Create a PostgreSQL service and set the IP addresses.
resource "aiven_pg" "example_postgres" {
  project      = aiven_project.example_project.project
  cloud_name   = "google-europe-west1"
  plan         = "startup-4"
  service_name = "example-pg-with-static-ips"

  static_ips = [for ip in aiven_static_ip.ips : ip.static_ip_address_id]

  pg_user_config {
    static_ips = true
  }
}
