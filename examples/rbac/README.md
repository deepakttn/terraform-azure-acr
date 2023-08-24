# RBAC example

Terraform configuration which creates an Azure Container Registry with the following features:

- 90 days log retention
- Basic SKU
- Administrator enabled
- User assigned identity with role `AcrPull`
- Send logs to Log Analytics Workspace


```markdown
## Azure Container Registry (ACR) Terraform Example with RBAC

This Terraform example code demonstrates how to create an Azure Container Registry (ACR) with Role-Based Access Control (RBAC) using the AzureRM provider. The code includes the creation of a resource group, a Log Analytics workspace, and the ACR with customizable options. It also assigns an RBAC role to a user-assigned managed identity to allow pull access to the ACR.

## Prerequisites

1. Install [Terraform](https://www.terraform.io/downloads.html) on your local machine.
2. Have an [Azure subscription](https://azure.microsoft.com/free/) and configure the Azure CLI.

## Usage

1. Clone this repository:

```bash
git clone https://github.com/YourUsername/YourRepository.git
cd YourRepository
```

2. Modify the `variables.tf` file to customize the variables according to your requirements, such as `location`, `pname`, and `env`.

3. Initialize Terraform:

```bash
terraform init
```

4. Review the planned changes:

```bash
terraform plan
```

5. Apply the changes:

```bash
terraform apply
```

## Configuration

- `provider "azurerm"` block sets up the AzureRM provider.
- `locals` block defines local variables used for naming resources.
- `resource "azurerm_resource_group" "rg"` creates an Azure resource group.
- `module "log_analytics"` creates a Log Analytics workspace.
- `module "acr"` creates the Azure Container Registry (ACR) with customizable options.
- `resource "azurerm_user_assigned_identity" "ua_id"` creates a user-assigned managed identity.
- `resource "azurerm_role_assignment" "acr_pull"` assigns an RBAC role to the user-assigned identity for pull access to the ACR.

## Variables

- `location`: The location to create the resources in.
- `pname`: Project name to be used in the locals.
- `env`: Environment name to be used in the locals.

## Outputs

- `registry_id`: The ID of the created Container Registry.
- `registry_name`: The name of the created Container Registry.
- `registry_login_server`: The login server of the created Container Registry.
- `registry_admin_username`: The admin username of the created Container Registry.
- `registry_admin_password`: The admin password of the created Container Registry.
- `sku`: The SKU tier for the created Container Registry.

## Clean Up

After you are done with the resources, you can use the following command to destroy them:

```bash
terraform destroy
```