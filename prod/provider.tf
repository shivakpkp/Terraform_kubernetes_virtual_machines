# Terraform configuration for the AzureRM provider version used by this deployment.
terraform {

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=5.0.0"
    }
  }
  backend "azurerm" {
    use_azuread_auth = true
  }
}

# Configure the Microsoft Azure provider with the required authentication details.
provider "azurerm" {
  features {}

}
