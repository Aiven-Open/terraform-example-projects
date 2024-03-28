# Create a Cassandra service.
resource "aiven_cassandra" "example_cassandra_service" {
  service_name = "example-cassandra"
  project      = aiven_project.example_project.project
  cloud_name   = "google-europe-west1"
  plan         = "startup-4"
}
# Create a fork of the Cassandra service.
resource "aiven_cassandra" "example_cassandra_fork" {
  service_name = "forked-cassandra"
  project      = aiven_project.example_project.project
  cloud_name   = "google-europe-west1"
  plan         = "startup-8"
  cassandra_user_config {
    service_to_fork_from = aiven_cassandra.cassandra_service.service_name
  }
}
