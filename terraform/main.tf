terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# Resource group de base
resource "azurerm_resource_group" "rg" {
  name     = "azure-uber-streaming-rg"
  location = "westeurope"
}

