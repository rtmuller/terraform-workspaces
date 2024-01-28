# Terraform Workspaces

This project leverages Terraform workspaces to provision and manage resources on AWS with different configurations for multiple environments. The key components of the project include:

1. `main.tf`: Defines the main resource configurations for the project, creating an AWS instance with details specified in the workspace-specific variables from `locals.tf`.

2. `backend.tf`: Configures the Terraform backend. This project utilizes a local backend for state management.

3. `provider.tf`: Sets up the AWS provider for Terraform, specifying the version and utilizing variables for region and profile configuration.

4. `variables.tf`: Declares variables such as `region`, with a default set to `us-east-1`.

5. `locals.tf`: Contains workspace-specific configurations, allowing for different instance names, types, and environments based on the active workspace.

6. `.gitignore`: Lists files and directories to be ignored by Git, including `.terraform` folders and `.tfstate` files.

Before using this project, ensure Terraform is installed and you have access to an AWS account. Modify the `region` variable in `variables.tf` and workspace configurations in `locals.tf` as needed.

Note: This project is structured for educational purposes to demonstrate the use of Terraform workspaces and may require additional adjustments for production readiness.

