# Basic example

Terraform configuration which creates an Azure Container Registry with the following features:

- 90 days log retention
- Basic SKU
- Administrator enabled
- Send logs to Log Analytics Workspace

## Prerequisites

To use this example, you need the following:

- An Azure account with appropriate permissions to create resources.
- Terraform installed on your local machine or integrated into your CI/CD pipeline.

## Usage

1. Clone this repository to your local machine.
2. Navigate to the example directory: `cd examples/acr-log-analytics`.
3. Modify the `variables.tf` file to configure your desired `location`, `pname` (project name), and `env` (environment name).
4. Initialize Terraform in the example directory: `terraform init`.
5. Review the plan: `terraform plan`.
6. Apply the changes: `terraform apply`.

## Inputs

- `location`: The location to create the resources in. Default: `northeurope`
- `pname`: Project name to be used in the locals. Default: `pname`
- `env`: Environment name to be used in the locals. Default: `env`

## Outputs

Once the resources are created, you will have access to the following outputs:

- `registry_id`: The ID of the Container Registry.
- `registry_name`: The name of the Container Registry.
- `registry_login_server`: The login server of the Container Registry.
- `registry_admin_username`: The admin username of the Container Registry.
- `registry_admin_password`: The admin password of the Container Registry.
- `sku`: The SKU tier of the Container Registry.