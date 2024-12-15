plugin "azurerm" {
  enabled = true
  version = "0.31.0" # Ensure this matches the latest compatible version of the TFLint AzureRM plugin
  source  = "github.com/terraform-linters/tflint-ruleset-azurerm"
}

# General Terraform rules
rule "terraform_deprecated_interpolation" {
  enabled = true
}

rule "terraform_unused_declarations" {
  enabled = true
}

rule "terraform_unused_variables" {
  enabled = true
}

rule "terraform_invalid_declaration" {
  enabled = true
}

# Azure-specific rules
rule "azurerm_invalid_resource_type" {
  enabled = true
}

rule "azurerm_invalid_variable_type" {
  enabled = true
}

rule "azurerm_redundant_tag" {
  enabled = true
}

rule "azurerm_standard_sku" {
  enabled = true
}

rule "azurerm_latest_version" {
  enabled = true
}

# Additional customizations as needed
