   # terraform-example-projects

   Terraform example files that can be used with the [Aiven Provider for Terraform](https://registry.terraform.io/providers/aiven/aiven/latest) to manage your Aiven infrastructure.

   # Get started

   1. Sign up for [Aiven](https://console.aiven.io/signup?utm_source=terraformregistry&utm_medium=organic&utm_campaign=terraform&utm_content=signup).
   2. Create a [personal token](https://aiven.io/docs/platform/howto/create_authentication_token). You can also create an [application user](https://aiven.io/docs/platform/howto/manage-application-users) and use its token for accessing the Aiven Provider.
   3. [Install Terraform](https://www.terraform.io/downloads). To confirm that you have Terraform v0.13.0 or higher installed, run:  

      ```sh
      $ terraform --version 
      ```

   4. Clone this repository.

   ## Run an example

   1. Add your Aiven token to the `terraform.tfvars` file for the example.

   2. In the directory for the example, initialize Terraform by running:
      
      ```sh
      $ terraform init
      ```

   3. To create an execution plan and preview the changes that will be made, run:

      ```sh
      $ terraform plan

      ```

   4. To deploy your changes, run:

      ```sh
      $ terraform apply --auto-approve
      ```

   5. To see your changes, log in to the [Aiven Console](https://console.aiven.io/).

   6. To remove all infrastructure changes, run: 
      
      ```sh
      $ terraform destroy 
      ```

   Start with the [get started](https://github.com/Aiven-Open/terraform-example-projects/tree/main/get-started) example to create your first organization, project, and user group in Aiven.

   # License

   terraform-example-projects is licensed under the Apache license, version 2.0. Full license text is available in the [LICENSE](LICENSE) file.

   Please note that the project explicitly does not require a CLA (Contributor License Agreement) from its contributors.

   # Contact

   [Contributions](CONTRIBUTING.md) and bug reports are very welcome. Post them as GitHub issues and pull requests at https://github.com/aiven/terraform-example-projects. 
   To report any possible vulnerabilities or other serious issues please see our [security](SECURITY.md) policy.
