resource "azurerm_container_registry" "acr" {
  name                = var.registry_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.sku
  admin_enabled       = var.admin_enabled
  public_network_access_enabled = var.public_network_access_enabled
  network_rule_bypass_option    = var.azure_services_bypass_allowed ? "AzureServices" : "None"

  data_endpoint_enabled = var.data_endpoint_enabled

  dynamic "retention_policy" {
    for_each = var.images_retention_enabled && var.sku == "Premium" ? ["enabled"] : []

    content {
      enabled = var.images_retention_enabled
      days    = var.images_retention_days
    }
  }

  dynamic "trust_policy" {
    for_each = var.trust_policy_enabled && var.sku == "Premium" ? ["enabled"] : []

    content {
      enabled = var.trust_policy_enabled
    }
  }

  dynamic "georeplications" {
    for_each = var.georeplications != null && var.sku == "Premium" ? var.georeplications : []

    content {
      location                = georeplications.value["location"]
      zone_redundancy_enabled = georeplications.value["zone_redundancy_enabled"]
    }
  }

  tags = merge(local.common_tags, tomap({
    "Env" : "Dev"
  }))
}

resource "azurerm_private_endpoint" "example" {
  name                = "${local.project_name_prefix}-endpoint"
  location            = var.location
  resource_group_name = var.resource_group_name
  #subnet_id           = data.terraform_remote_state.vnet.outputs.subnet_ids["aks_subnet"]
  subnet_id           = var.subnet_id 

  private_service_connection {
    name                           = "${local.project_name_prefix}-privateconn"
    private_connection_resource_id = azurerm_container_registry.acr.id
    subresource_names              = ["registry"]
    is_manual_connection           = false
  }
  tags = merge(local.common_tags, tomap({
    "Env" : "Dev"
  }))
}


resource "azurerm_container_registry_webhook" "webhook" {
  for_each = var.webhooks

  name                = each.value.name
  registry_name       = azurerm_container_registry.acr.name
  location            = var.location
  resource_group_name = var.resource_group_name

  service_uri = each.value.service_uri
  actions     = each.value.actions
  status      = each.value.status
  scope       = each.value.scope

  tags = merge(local.common_tags, tomap({
    "Env" : "Dev"
  }))
}