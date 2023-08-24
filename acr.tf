resource "azurerm_container_registry" "acr" {
  name                = var.registry_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.sku
  admin_enabled       = var.admin_enabled

  dynamic "georeplications" {
    for_each = var.georeplications

    content {
      location                = georeplications.value["location"]
      zone_redundancy_enabled = georeplications.value["zone_redundancy_enabled"]
    }
  }

  tags = merge(local.common_tags, tomap({
    "Name" : local.project_name_prefix
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
    "Name" : local.project_name_prefix
  }))
}