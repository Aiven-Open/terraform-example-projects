# Create static IP addresses for your Aiven service

Cloud providers dynamically assign public IP addresses from their connection pools to Aiven services when you create them. These IP addresses change during service maintenance. 

You can create [static IP addresses](https://aiven.io/docs/platform/concepts/static-ips) for an additional charge. Static IP addresses belong to a project and are created in the cloud provider.

This example creates a project, 6 static IP addresses, and a PosgreSQL service that uses the IP addresses.