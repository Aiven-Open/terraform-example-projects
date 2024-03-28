terraform {
  required_version = ">=0.13"
  required_providers {
    aiven = {
      source  = "aiven/aiven"
      version = ">=4.0.0, <5.0.0"
    }
  }
}

provider "aiven" {
  api_token = var.aiven_token
}


# Create an organization.
resource "aiven_organization" "main" {
  name = "Example Organization"
}


# Create units within the organization for the engineering
# and finance departments.
resource "aiven_organizational_unit" "eng_unit" {
  name = "Engineering"
  parent_id = aiven_organization.main.id
}

resource "aiven_organizational_unit" "finance_unit" {
  name = "Finance"
  parent_id = aiven_organization.main.id
}

# Create three projects in each unit: production,
# QA, and development.

# Engineering projects
resource "aiven_project" "eng_prod" {
  project    = "${var.prod_project_name}-eng"
  parent_id = aiven_organizational_unit.eng_unit.id
}

resource "aiven_project" "eng_qa" {
  project    = "${var.qa_project_name}-eng"
  parent_id = aiven_organizational_unit.eng_unit.id
}

resource "aiven_project" "dev-eng" {
  project    = "${var.dev_project_name}-eng"
  parent_id = aiven_organizational_unit.eng_unit.id
}

# Finance projects
resource "aiven_project" "fin_prod" {
  project    = "${var.prod_project_name}-fin"
  parent_id = aiven_organizational_unit.finance_unit.id
}

resource "aiven_project" "fin_qa" {
  project    = "${var.qa_project_name}-fin"
  parent_id = aiven_organizational_unit.finance_unit.id
}

resource "aiven_project" "fin_dev" {
  project    = "${var.dev_project_name}-fin"
  parent_id = aiven_organizational_unit.finance_unit.id
}