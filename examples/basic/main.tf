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

  # registry_name              = "${local.name_prefix}cr"
  location                   = azurerm_resource_group.rg.location
  resource_group_name        = azurerm_resource_group.rg.name
  log_analytics_workspace_id = module.log_analytics.workspace_id

  container_registry_config = {
    name = "${local.name_prefix}cr"
  }

  blob_backend_config = {
    rg_name              = azurerm_resource_group.rg.name
    storage_account_name = "saname"
    container_name       = "cname"
    key                  = "key.backend"
  }
}