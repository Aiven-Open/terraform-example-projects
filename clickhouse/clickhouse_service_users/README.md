# Create ClickHouse® service users and roles

Create service users with different permission levels. In this example, an Aiven for ClickHouse service is used to store IoT sensor data.
You create the service, two service users, and assign each user a role:

* Give the ETL user permission to insert data.
* Give the analyst user access to view data in the measurements database.

You can read more about privileges in the [ClickHouse documentation](https://clickhouse.com/docs/en/sql-reference/statements/grant#privileges).

After running the example, you can see your service users and their roles in the [Aiven Console](https://console.aiven.io/):

1. In the ClickHouse service, click **Users and roles**. 

2. Click **View details & grants**.

You can also see the admin user that is automatically created for the service.
