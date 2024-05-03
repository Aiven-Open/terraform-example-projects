# Create an Aiven for Apache Kafka service.
resource "aiven_kafka" "main" {
  project                 = aiven_project.example_project.project
  cloud_name              = "aws-eu-west-1"
  plan                    = "business-4"
  service_name            = "example-aws-privatelink-kafka"
  maintenance_window_dow  = "monday"
  maintenance_window_time = "10:00:00"
  project_vpc_id          = "AWS_PROJECT_VPC_ID"

  kafka_user_config {
    privatelink_access {
      kafka = true
    }

    public_access {
      kafka = true
    }

    kafka_authentication_methods {
      certificate = true
    }
  }
}

# AWS PrivateLink service. Replace AWS_ACCOUNT_ID with the ID for your AWS account 
# and ROLE_NAME with the name of the IAM role you're using for AWS PrivateLink.
resource "aiven_aws_privatelink" "main" {
  project      = aiven_project.example_project.project
  service_name = aiven_kafka.main.service_name
  principals = [
    "arn:aws:iam::AWS_ACCOUNT_ID:role/ROLE_NAME",
  ]
}

output "aws_privatelink" {
  value = aiven_aws_privatelink.main
}

# After connecting to a VPC endpoint from your AWS account
# a new service component is available.
data "aiven_service_component" "kafka_privatelink" {
  project                     = aiven_aws_privatelink.example_project.project
  service_name                = aiven_aws_privatelink.main.service_name
  component                   = "kafka"
  route                       = "privatelink"
  kafka_authentication_method = "certificate"
}

output "kafka_privatelink_component" {
  value = data.aiven_service_component.kafka_privatelink
}
