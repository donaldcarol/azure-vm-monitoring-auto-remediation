provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {

  name     = "rg-dev-network"
  location = "westeurope"

}

module "vnet" {

  source = "../../modules/vnet"

  vnet_name           = "vnet-dev"
  location            = "westeurope"
  resource_group_name = azurerm_resource_group.rg.name

  address_space       = ["10.20.0.0/16"]

}