# Integrate ClickHouse with a PostgreSQL source

This example creates an Aiven for Apache PostgreSQL® service with three databases and integrates it with an Aiven for ClickHouse® service.

The databases are based on an inventory analytics use case:

- `suppliers_dims` has information on suppliers with dimension tables for joins and reporting
- `inventory_facts` is used for inventory details with aggregated fact tables to enrich reports
- `order_events` stores orders with event-sourced tables that can compute near-real-time stats


The `postgres.tf` file creates the PostgreSQL service and its databases.

To expose the PostgreSQL databases in ClickHouse, the `clickhouse.tf` file creates a ClickHouse service and an integration with the PostgreSQL service.

Once the services are running, the three databases will be accessible in ClickHouse with these names:

- `service_postgres-gcp-us_suppliers_dims_public`
- `service_postgres-gcp-us_inventory_facts_public`
- `service_postgres-gcp-us_order_events_public`

The `project.tf` file creates a project to hold these services. Project names must be unique, so we suggest adding your organization's name as a prefix in the `project.tf` file.

You can see these integrated services and databases in the project in the [Aiven Console](https://console.aiven.io/).