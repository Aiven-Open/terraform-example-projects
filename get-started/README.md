# Get started with Aiven Provider for Terraform 

Set up your organization on Aiven by creating your first Aiven project and user group.

This example creates a project and user group in your organization, and gives the user group access to the project. You can add users to the group after they accept the [invite to your organization](https://aiven.io/docs/platform/howto/manage-org-users). When you add groups to projects, you can give them the `admin` `developer`, `operator`, or `read_only` [project role](https://aiven.io/docs/platform/reference/project-member-privileges).

## Prerequisites

* [Install Terraform](https://www.terraform.io/downloads)
* [Sign up for Aiven](https://console.aiven.io/signup?utm_source=github&utm_medium=organic&utm_campaign=devportal&utm_content=repo)
* [Create a personal token](https://docs.aiven.io/docs/platform/howto/create_authentication_token.html)

## Create your first Aiven resources

1. Ensure that you have Terraform v0.13.0 or higher installed. To check the version, run:  

   ```sh
   $ terraform --version 
   ```

   The output is similar to the following:

   ```sh
   Terraform v1.6.2
   + provider registry.terraform.io/aiven/aiven v4.9.2
   ```

2. Clone this repository.

3. Replace the placeholders in the `get-started.tf` file and add your token to the `terraform.tfvars` file.

4. To initialize Terraform in the `get-started` directory, run:

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

5. To create an execution plan and preview the changes that will be made, run:

   ```sh
   $ terraform plan

   ```

6. To deploy your changes, run:

   ```sh
   $ terraform apply --auto-approve
   ```

   The output will be similar to the following:

   ```sh
   aiven_project.example_project: Creating...
   ...
   Apply complete! Resources: 4 added, 0 changed, 0 destroyed.
   ```

## Verify the changes in the Aiven Console 

You can see your project and user group in the [Aiven Console](https://console.aiven.io/):

1. In the organization, click **Projects** and select your project.

2. Click **Members** to see the user group you added to this project.


To see the user group details:

1. Click **Admin**. 

2. Click **Groups**. 

3. Select the user group to see more information, including the members of the group.


## Clean up

To delete the example project and user group:

1. Preview the changes by running:

   ```sh
   $ terraform plan -destroy 
   ```

2. To delete all resources, run:

   ```sh
   $ terraform destroy 
   ```

3. Enter yes to confirm the changes:

   ```sh
   Plan: 0 to add, 0 to change, 4 to destroy
   ...

   Do you really want to destroy all resources?
     Terraform will destroy all your managed infrastructure, as shown above.
     There is no undo. Only 'yes' will be accepted to confirm.

     Enter a value: yes
   ```

   The output will be similar to the following:

   ```sh
   ...
   aiven_organization_user_group_member.group-members: Destroying...
   ...
   Destroy complete! Resources: 4 destroyed.
   ```
