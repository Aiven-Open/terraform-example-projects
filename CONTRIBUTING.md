# Welcome!

Contributions are very welcome on terraform-example-projects. When contributing please keep this in mind:

- Open an issue to discuss new bigger changes.
- Write code consistent with the project style and make sure the tests are passing.
- Stay in touch with us if we have follow up questions or requests for further changes.


## Writing examples

Review the examples and try to use a similar format. Follow these style guidelines to help keep the examples consistent and easy to use:

* Use `main` as the resource name when you're using that type of resource once in an example. If you use the same type of resource more than once, try to give them meaningful names like `primary` and `secondary`. The following is an example:

  ```terraform
  resource "aiven_organization" "main" {
    name = "Example organization"
  }

  resource "aiven_organization_user_group" "admin_group" {
    name = "Administrators"
    description = "Aiven admin"
    organization_id = aiven_organization.main.id

  resource "aiven_organization_user_group" "dev_group" {
    name = "Developers"
    description = "Dev team"
    organization_id = aiven_organization.main.id
  } 
  ```

* Put the `name` argument first in a resource block. 
 
* Use a variable for the Aiven `api_token`.

* Include a terraform.tfvars file to define variables.

# Opening a PR

- Commit messages should describe the changes, not the filenames. Win our admiration by following
  the [excellent advice from Chris Beams](https://chris.beams.io/posts/git-commit/) when composing
  commit messages.
- Choose a meaningful title for your pull request.
- The pull request description should focus on what changed and why.
- Check that the tests pass.
