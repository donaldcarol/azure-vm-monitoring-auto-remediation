resource "azurerm_windows_virtual_machine" "winvm" {
  name                = "vm-${var.prefix}-win"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  size                = var.windows_vm_size
  admin_username      = var.windows_admin_username
  admin_password      = var.windows_admin_password
  tags                = var.tags

  network_interface_ids = [
    azurerm_network_interface.nic_windows.id
  ]


  lifecycle {
    ignore_changes = [
      patch_mode,
      identity,
      bypass_platform_safety_checks_on_user_schedule_enabled
    ]
  }

  os_disk {
    name                 = "osdisk-${var.prefix}-win"
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-datacenter"
    version   = "latest"
  }

  provision_vm_agent        = true
  automatic_updates_enabled = true
  patch_mode                = "AutomaticByOS"
}



resource "azurerm_linux_virtual_machine" "linuxvm" {
  name                = "vm-${var.prefix}-linux"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  size                = var.linux_vm_size
  admin_username      = var.linux_admin_username
  tags                = var.tags

  disable_password_authentication = true

  network_interface_ids = [
    azurerm_network_interface.nic_linux.id
  ]

  lifecycle {
    ignore_changes = [
      patch_mode,
      identity,
      bypass_platform_safety_checks_on_user_schedule_enabled
    ]
  }


  admin_ssh_key {
    username   = var.linux_admin_username
    public_key = file(var.linux_public_key_path)
  }

  os_disk {
    name                 = "osdisk-${var.prefix}-linux"
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  computer_name = "linuxvm"
}