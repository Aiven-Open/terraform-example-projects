# Create a data processing pipeline with Kafka and Flink

Using service integrations, you can send data from topics in an Aiven for Apache Kafka® service to an Aiven for Apache Flink® service for processing. [Applications in Flink](https://aiven.io/docs/products/flink/concepts/flink-applications) have source and sink tables, and use Flink jobs for real-time data stream processing.

In this example, you create:
- a Kafka service with a source topic and a sink topic
- a Flink service
- a service integration between Kafka and Flink
- a Flink application to process the topic data

The use case is data center machines sending data about CPU usage. These metrics are sent to the `cpu_measurements` topic. This data is added to Flink's source table and the application creates a sink table for values higher than 85. Those are sent to the Kafka sink topic `cpu_high_usage`.

After running the example, you can see a visual overview of the data pipeline in the [Aiven Console](https://console.aiven.io/). In the Flink service, click **Applications** > **example-app**.

