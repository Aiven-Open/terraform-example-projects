terraform {
  required_version = ">=0.13"
  required_providers {
    aiven = {
      source  = "aiven/aiven"
      version = ">=4.0.0, <5.0.0"
    }
  }
}

variable "aiven_token" {
  description = "Aiven token"
  type        = string
}


provider "aiven" {
  api_token = var.aiven_token
}

# Replace ORGANIZATION_NAME with the name
# of your Aiven organization.
data "aiven_organization" "main" {
  name = "ORGANIZATION_NAME"
}

# Create a project in your organization. 
# Project names must be globally unique. It's recommended 
# to use your organization name as a prefix for the project name. 
resource "aiven_project" "example_project" {
  project    = "ORGANIZATION_NAME-first-project"
  parent_id = data.aiven_organization.main.id
}

# Create a user group.
resource "aiven_organization_user_group" "example_group" {
  organization_id = data.aiven_organization.main.id
  name       = "Example user group"
  description = "The first user group for this organization."
}

# Add an organization user to the group.
# Replace USER_ID with the ID of the user. 
resource "aiven_organization_user_group_member" "example_member" {
  group_id      = aiven_organization_user_group.example_group.group_id 
  organization_id = data.aiven_organization.main.id
  user_id = "USER_ID"
}

# Give the group access to the project with the developer role.
resource "aiven_organization_group_project" "dev_project_member" {
  group_id      = aiven_organization_user_group.example_group.group_id
  project = aiven_project.example_project.project
  role    = "developer"
}

