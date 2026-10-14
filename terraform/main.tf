terraform {
    required_version = ">=1.0.0"
    required_providers {
        azurerm = {
            source = "hashicorp/azurerm"
            version = ">=4.0"
        }
    }
}

provider "azurerm" {
    features {}
}

resource "azurerm_resource_group" "rg" {
  name = var.resource_group_name
  location = var.location
}

resource "azurerm_service_plan" "asp" {
    name = var.asp_name
    resource_group_name = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location
    sku_name = "B1"
    os_type = "Windows" 
}

resource "azurerm_windows_web_app" "webapp" {
  name = var.webapp_name
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  service_plan_id = azurerm_service_plan.asp.id
  site_config {}
}