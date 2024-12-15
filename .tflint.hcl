plugin "azurerm" {
    enabled = true
    version = "0.27.0"
    source  = "github.com/terraform-linters/tflint-ruleset-azurerm"
}

# General Terraform rules
rule "terraform_deprecated_interpolation" {
  enabled = true
}

# Azure-specific rules
rule "azurerm_invalid_resource_type" {
  enabled = true
}

rule "azurerm_invalid_variable_type" {
  enabled = true
}

rule "azurerm_standard_sku" {
  enabled = true
}

rule "azurerm_latest_version" {
  enabled = true
}

# Additional customizations as needed
