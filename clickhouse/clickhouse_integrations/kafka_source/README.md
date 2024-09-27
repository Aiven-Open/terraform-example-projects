# Integrate ClickHouse with a Kafka source

This example creates an Aiven for Apache Kafka® service and integrates it with an Aiven for ClickHouse® service.

The `kafka.tf` file creates the Kafka service with a topic named `edge-measurements` to ingest messages from IoT edge devices. The IoT measurements are in the following format:

```javascript

  {
    "sensor_id": 10000001,
    "ts": "2022-12-01T10:08:24.446369",
    "key": "pressure_pa",
    "value": 101.325
  }
```

The `clickhouse.tf` file creates the ClickHouse service and an integration with the Kafka service. It also adds two databases to the ClickHouse service.
One database is for the source topic containing edge measurements in JSON format. It will be named `service_example-kafka` and have an `edge_measurements_raw` table using the Kafka ClickHouse engine. The 
other database, `iot_analytics` is for downstream transformation and aggregation of the raw data.

The `access.tf` file creates ClickHouse service users and roles for writing and reading the data.

The `project.tf` file creates a project to hold these services. Project names must be unique, so we suggest adding your organization's name as a prefix in the `project.tf` file.

After running the example, you can see your integrated services in the project in the [Aiven Console](https://console.aiven.io/).