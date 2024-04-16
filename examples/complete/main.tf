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

module "vnet" {
  source              = "git::https://github.com/tothenew/terraform-azure-vnet.git"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  address_space       = "10.41.0.0/20"

  virtual_network_peering = false

  subnets = {
    "aks_subnet" = {
      address_prefixes           = ["10.41.1.0/24"]
      associate_with_route_table = false
      is_natgateway              = false
      is_nsg                     = true
      service_delegation         = false
    }
  }
}

module "acr" {
  source = "../.."

  registry_name              = "${local.name_prefix}cr"
  location                   = azurerm_resource_group.rg.location
  resource_group_name        = azurerm_resource_group.rg.name
  log_analytics_workspace_id = module.log_analytics.workspace_id
  admin_enabled              = false
  sku                        = "Premium"
  subnet_id                  = module.vnet.subnet_ids["aks_subnet"] 
  images_retention_enabled   = false
  trust_policy_enabled       = false 
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
    # "webapp" = {
    #   name        = "webappwebhook"
    #   service_uri = "https://webappwebhookreceiver.example/webapptag"
    #   actions     = ["push"]
    #   status      = "enabled"
    #   scope       = "webapptag:*"
    # }
  }
}
