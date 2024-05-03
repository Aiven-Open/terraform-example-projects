# Aiven organizations, units, and projects example

The Aiven platform uses [organizations, organizational units, and projects](https://aiven.io/docs/platform/concepts/projects_accounts_access) to organize services.

This example shows you how to use the Aiven Provider for Terraform to create an organization with two organizaitonal units, and add projects to those units. 

Many customers use units to separate projects for different departments within their organization, so this example will create a unit for an engineering department and a finance department. In each unit, three projects will be created for production, QA, and development environments. 

## Prerequisites

* [Install Terraform](https://www.terraform.io/downloads)
* [Sign up for Aiven](https://console.aiven.io/signup?utm_source=github&utm_medium=organic&utm_campaign=devportal&utm_content=repo)
* [Create a token](https://aiven.io/docs/platform/howto/create_authentication_token)

## Set up the Terraform project

1. Clone this repository.

2. Add values for the variables in the `terraform.tfvars` file. It's recommended to use your organization name as a prefix for the project names.

3. Ensure that you have Terraform v0.13.0 or higher installed. To check the version, run:  

   ```sh
   $ terraform --version 
   ```

   The output is similar to the following:

   ```sh
   Terraform v1.6.2
   + provider registry.terraform.io/aiven/aiven v4.9.2
   ```

4. To initialize Terraform, run:

   ```sh
   $ terraform init
   ```

   The output is similar to the following:

   ```sh

   Initializing the backend...

   Initializing provider plugins...
   - Finding aiven/aiven versions matching ">= 4.0.0, < 5.0.0"...
   - Installing aiven/aiven v4.9.2...
   - Installed aiven/aiven v4.9.2
   ...
   Terraform has been successfully initialized!
   ...
   ```

5. To create an execution plan and preview the changes, run:

   ```sh
   $ terraform plan

   ```

6. To deploy your changes, run:

   ```sh
   $ terraform apply --auto-approve
   ```

   The output will be similar to the following:

   ```sh
   aiven_organization.org: Creating...
   ...
   Apply complete! Resources: 9 added, 0 changed, 0 destroyed.
   ```

## Verify the setup in the Aiven Console 

You can see your organization, organizational units, and projects in the [Aiven Console](https://console.aiven.io/):

1. In the organization, click **Admin**. 

2. In the **Organizational units** section, select a unit.

On the unit's page, you can see a list of the projects.

## Clean up

To delete the example organization, organizational units, and all projects:

1. To preview the changes first, run:

   ```sh
   $ terraform plan -destroy 
   ```

2. To delete all resources, run:

   ```sh
   $ terraform destroy 
   ```

3. Enter yes to confirm the changes:  

   ```sh
   Plan: 0 to add, 0 to change, 9 to destroy
   ...

   Do you really want to destroy all resources?
     Terraform will destroy all your managed infrastructure, as shown above.
     There is no undo. Only 'yes' will be accepted to confirm.

     Enter a value: yes
   ```

   The output will be similar to the following:

   ```sh
   ...
   aiven_organization.org: Destruction complete after 0s

   Destroy complete! Resources: 9 destroyed.
   ```
