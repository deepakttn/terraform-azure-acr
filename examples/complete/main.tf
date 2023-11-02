provider "azurerm" {
  features {}
}

locals {
  env         = var.env
  name        = var.pname
  name_prefix = "${local.env}${local.name}"
}

resource "azurerm_resource_group" "rg" {
  name     = "${local.name_prefix}rg"
  location = var.location
}

module "log_analytics" {
  source = "git::https://github.com/tothenew/terraform-azure-loganalytics.git"

  workspace_name      = "${local.name_prefix}-log"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
}

module "acr" {
  # source = "git::https://github.com/tothenew/terraform-azure-acr.git"
  source = "../.."

  registry_name              = "${local.name_prefix}cr"
  location                   = azurerm_resource_group.rg.location
  resource_group_name        = azurerm_resource_group.rg.name
  log_analytics_workspace_id = module.log_analytics.workspace_id
  admin_enabled              = false
  sku                        = "Premium"

  # If one or more georeplications block is specified, they are expected to follow the alphabetic order on the location property.
  georeplications = [
    {
      location                = "Norway East"
      zone_redundancy_enabled = false
    },
    {
      location                = "West Europe"
      zone_redundancy_enabled = false
    }
  ]

  webhooks = {
    "webapp" = {
      name        = "webappwebhook"
      service_uri = "https://webappwebhookreceiver.example/webapptag"
      actions     = ["push"]
      status      = "enabled"
      scope       = "webapptag:*"
    }
    # "sql" = {
    #   name        = "sqlwebhook"
    #   service_uri = "https://sqlwebhookreceiver.example"
    #   actions     = ["push"]
    # }
  }
}
