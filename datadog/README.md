# Send metrics from your Aiven services to Datadog

Datadog is an observability platform that includes products for ingesting logs and metrics for monitoring. 
You can use Aiven's integration with Datadog to send metris from your Aiven services to external Datadog dashboards.

This example creates an Aiven for Apache Kafka® service in one of your projects and a Datadog integration endpoint 
to send the data from the service to your Datadog dashboards.

## Prerequisites

- A Datadog account
- A Datadog [API key](https://docs.datadoghq.com/account_management/api-app-keys/)
- An Aiven project

## Set up the Terraform project

1. Add values for the variables in the `terraform.tfvars` file. You can get the parameter for your
   Datadog site from the [Datadog documentation](https://docs.datadoghq.com/getting_started/site/)..

2. In the `service.tf` file, add your project's name to the `aiven_project` data source.

3. To initialize Terraform, run:

   ```sh
   $ terraform init
   ```

4. To preview the changes, run:

   ```sh
   $ terraform plan

   ```

5. To deploy your changes, run:

   ```sh
   $ terraform apply --auto-approve
   ```

## Verify the setup

You can see your service and integration in the [Aiven Console](https://console.aiven.io/):

1. In the project, select the Kafka service.

2. Click **Integrations** to see your Datadog integration.

In Datadog, you can see the metrics on your dashboards.