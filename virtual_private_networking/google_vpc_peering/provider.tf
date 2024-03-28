terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 3.0"
    }
    aiven = {
      source  = "aiven/aiven"
      version = ">=4.0.0, <5.0.0"
    }
  }
}
provider "aiven" {
  api_token = var.aiven_token
}
provider "google" {
  project = var.gc_project_id
  region  = "us-central1"
  zone    = "us-central1-a"
}