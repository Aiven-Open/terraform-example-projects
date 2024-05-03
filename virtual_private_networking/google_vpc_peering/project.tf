# Get details of your Aiven project.
data "aiven_project" "example_project" {
  project = var.aiven_project_name
}
# Create a VPC in Google Cloud.
resource "google_compute_network" "google_cloud_vpc" {
  name                    = "example-google-cloud-vpc"
  auto_create_subnetworks = "false"
}
# Create a subnet in the Google Cloud VPC.
resource "google_compute_subnetwork" "google_cloud_subnet" {
  name          = "example-subnet"
  region        = "us-central1"
  ip_cidr_range = "10.0.0.0/24"
  network       = google_compute_network.google_cloud_vpc.self_link
}

# Create a VPC in your Aiven project.
# Ensure that this CIDR range does not overlap with the CIDR range of your Google Cloud VPC. 
resource "aiven_project_vpc" "aiven_vpc" {
  project      = data.aiven_project.example_project.project
  cloud_name   = "google-us-central1"
  network_cidr = "192.168.0.0/24"
}