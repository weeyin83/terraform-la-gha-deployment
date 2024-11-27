terraform {
  required_version = ">= 1.3.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.71, < 5.0.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.5.0, < 4.0.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "tfstate-demo-rg"
    storage_account_name = "tfstatesademo"
    container_name       = "tfstate"
    key                  = "tfdemo.ga.tfstate"
  }
}



provider "azurerm" {
  features {}
  subscription_id = "6a2908bc-22da-454c-bfb9-87edf787700b"
}

# This ensures we have unique CAF compliant names for our resources.
module "naming" {
  source  = "Azure/naming/azurerm"
  version = "0.3.0"
}

locals {
  azure_regions = [
    "ukwest",
    "westeurope",
    "francecentral",
    "swedencentral"
    # Add other regions as needed
  ]
}


variable "enable_telemetry" {
  description = "Enable or disable telemetry for the log analytics workspace"
  type        = bool
  default     = true # Set a default value if desired
}


# This picks a random region from the list of regions.
resource "random_integer" "region_index" {
  max = length(local.azure_regions) - 1
  min = 0
}

# Add a new random_pet resource to generate a unique, human-readable name
resource "random_pet" "log_analytics_workspace_name" {
  length    = 2
  separator = "-"
}

# This is required for resource modules
resource "azurerm_resource_group" "rg" {
  location = local.azure_regions[random_integer.region_index.result]
  name     = module.naming.resource_group.name_unique
}

# This is the module call
module "log_analytics_workspace" {
  source = "Azure/avm-res-operationalinsights-workspace/azurerm"
  version = "0.4.2"
  # source             = "Azure/avm-res-operationalinsights-workspace/azurerm"
  enable_telemetry                          = var.enable_telemetry
  location                                  = azurerm_resource_group.rg.location
  resource_group_name                       = azurerm_resource_group.rg.name
  name                                      = "law-${random_pet.log_analytics_workspace_name.id}"
  log_analytics_workspace_retention_in_days = 60
  log_analytics_workspace_sku               = "PerGB2018"
  log_analytics_workspace_daily_quota_gb    = 200
  log_analytics_workspace_identity = {
    type = "SystemAssigned"
  }
}
