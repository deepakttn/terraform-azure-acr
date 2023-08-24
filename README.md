# Terraform Module: Azure Container Registry

[![Lint Status](https://github.com/tothenew/terraform-aws-template/workflows/Lint/badge.svg)](https://github.com/tothenew/terraform-aws-template/actions)
[![LICENSE](https://img.shields.io/github/license/tothenew/terraform-aws-template)](https://github.com/tothenew/terraform-aws-template/blob/master/LICENSE)

This Terraform module creates an Azure Container Registry (ACR) and sets up webhooks and diagnostic settings.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [azurerm](#requirement\_terraform) | >= 3.39.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_container_registry](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry) | resource |
| [azurerm_monitor_diagnostic_setting](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_container_registry_webhook](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry_webhook) | resource |

## Resources Created

- Azure Container Registry (ACR)
- ACR Webhooks
- ACR Diagnostic Settings for Log Analytics

## Prerequisites

Before using this Terraform module, ensure that you have the following prerequisites:

1. **Azure Account**: You need an active Azure account to deploy the resources.
2. **Terraform**: Install Terraform on your local machine. You can download it from the [official Terraform website](https://www.terraform.io/downloads.html).
3. **Azure CLI**: Install the Azure CLI on your local machine. You can download it from the [Azure CLI website](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli).

- Terraform version >= 1.3.0 is required.
- Azure provider version >= 3.16.0 is required.

## Getting Started with Azure Container Registry Terraform Module

This repository contains a Terraform module to create an Azure Container Registry.

### Configure Azure Provider

To configure the Azure provider, you need to set up the necessary Azure credentials. If you already have the Azure CLI installed and authenticated with Azure, Terraform will use the same credentials.

If you haven't authenticated with Azure, you can do so by running:

```bash
az login
```

### Clone the Repository

First, clone this repository to your local machine using the following command:

```bash
git clone <repository_url>
cd <repository_name>
```

### Initialize Terraform

Once you have cloned the repository, navigate to the module directory and initialize Terraform:

```bash
cd path/to/module_directory
terraform init
```

This will download the necessary plugins required for Terraform to work with Azure.

### Apply the Terraform Configuration

After configuring the input variables, you can apply the Terraform configuration to create the Azure Container Registry:

```bash
terraform apply
```

Terraform will show you the changes that will be applied to the infrastructure. Type `yes` to confirm and apply the changes.

### Clean Up

To clean up the resources created by Terraform, you can use the `destroy` command:

```bash
terraform destroy
```

Terraform will show you the resources that will be destroyed. Type `yes` to confirm and destroy the resources.


## Inputs

| Name                                   | Description                                       | Type          | Default            |
|----------------------------------------|---------------------------------------------------|---------------|--------------------|
| `registry_name`                        | The name of the Container Registry.              | `string`      |                    |
| `location`                             | The Azure location for the resources.            | `string`      |                    |
| `resource_group_name`                  | The name of the resource group.                  | `string`      |                    |
| `sku`                                  | The SKU tier for the Container Registry.         | `string`      | `"Basic"`          |
| `admin_enabled`                        | Is admin enabled for the Container Registry?    | `bool`        | `false`            |
| `georeplications`                      | Geo-replication configurations.                 | `list(object)`| `[]`               |
| `webhooks`                             | Map of webhooks to create.                      | `map(object)` | `{}`               |
| `log_analytics_workspace_id`           | ID of the Log Analytics workspace.              | `string`      |                    |
| `log_analytics_destination_type`       | Type of log analytics destination.              | `string`      | `null`             |
| `diagnostic_setting_enabled_log_categories` | Enabled log categories for diagnostic settings. | `list(string)`| `[...]`            |
| `diagnostic_setting_name`              | Name of the diagnostic setting.                 | `string`      | `"audit-logs"`     |
| `name`                                 | Prefix for resource names.                      | `string`      | `""`               |
| `default_tags`                         | Common tags for resources.                      | `map(string)` | `{...}`            |
| `common_tags`                          | Additional common tags for resources.           | `map(string)` | `{}`               |

## Outputs

| Name                                   | Description                                       | Type          |
|----------------------------------------|---------------------------------------------------|---------------|
| `registry_id`                          | ID of the Container Registry.                    | `string`      |
| `registry_name`                        | Name of the Container Registry.                  | `string`      |
| `registry_login_server`                | Login server of the Container Registry.          | `string`      |
| `registry_admin_username`              | Admin username of the Container Registry.        | `string`      |
| `registry_admin_password`              | Admin password of the Container Registry.        | `sensitive`   |
| `sku`                                  | SKU tier of the Container Registry.              | `string`      |

## Usage

```hcl
module "acr" {
  source             = "path/to/module"
  registry_name      = "myacr"
  location           = "East US"
  resource_group_name= "myresourcegroup"
  log_analytics_workspace_id = "workspace-id"
  
  webhooks = {
    "webhook-1" = {
      name        = "webhook-1"
      service_uri = "https://example.com"
    }
  }
}
```


## List of variables

| Variable Name                              | Description                                                        | Type            | Required | Default Value       |
|--------------------------------------------|--------------------------------------------------------------------|-----------------|----------|---------------------|
| `registry_name`                            | The name of this Container Registry.                               | `string`        | Yes      |                     |
| `location`                                 | The supported Azure location where the resources exist.            | `string`        | Yes      |                     |
| `resource_group_name`                      | The name of the resource group in which to create the resources.   | `string`        | Yes      |                     |
| `sku`                                      | The SKU tier for the Container Registry.                           | `string`        | No       | `"Basic"`           |
| `admin_enabled`                            | Is admin enabled for this Container Registry?                     | `bool`          | No       | `false`             |
| `georeplications`                          | A list of properties of the geo-replication blocks for this Container Registry. Only available for Premium SKU. | `list(object)` | No | `[]` |
| `webhooks`                                 | A map of webhooks to create for this Container Registry.           | `map(object)`   | No       | `{}`                |
| `log_analytics_workspace_id`               | The ID of the Log Analytics workspace to send diagnostics to.      | `string`        | Yes      |                     |
| `log_analytics_destination_type`           | The type of log analytics destination to use for this Log Analytics Workspace. | `string` | No | `null`            |
| `diagnostic_setting_enabled_log_categories`| A list of log categories to be enabled for this diagnostic setting.| `list(string)`  | No       | `["ContainerRegistryLoginEvents", "ContainerRegistryRepositoryEvents"]` |
| `diagnostic_setting_name`                  | The name of this Diagnostic Setting.                               | `string`        | No       | `"audit-logs"`      |
| `name`                                     | A string value to describe the prefix of all the resources.        | `string`        | No       | `""`                |
| `default_tags`                             | A map to add common tags to all the resources.                     | `map(string)`   | No       | See below           |
| `common_tags`                              | A map to add common tags to all the resources.                     | `map(string)`   | No       | `{}`                |

Default value for `default_tags`:
```hcl
{
  "Scope": "ACR",
  "CreatedBy": "Terraform"
}
```

Please note that the variables in the "Required" column that are marked "No" can be left empty if you don't want to provide a value for them.

## Note

- The Terraform configuration may contain sensitive information like passwords or keys. Make sure to handle these securely using Terraform workspaces, environment variables, or other secure methods.

- This module assumes that the required Azure provider is already configured in the Terraform configuration and has the correct credentials to authenticate with Azure.

- Refer to the official Terraform documentation for more details on using modules and configuring Azure resources with Terraform.

- For more information on the Azure Container Group resource, refer to the Azure provider documentation.

## Authors

Module managed by [TO THE NEW Pvt. Ltd.](https://github.com/tothenew)

## License

Apache 2 Licensed. See [LICENSE](https://github.com/tothenew/terraform-aws-template/blob/main/LICENSE) for full details.