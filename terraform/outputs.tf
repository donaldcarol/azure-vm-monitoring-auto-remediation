output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "log_analytics_workspace_name" {
  value = azurerm_log_analytics_workspace.law.name
}

output "windows_vm_name" {
  value = azurerm_windows_virtual_machine.winvm.name
}

output "linux_vm_name" {
  value = azurerm_linux_virtual_machine.linuxvm.name
}

output "windows_public_ip" {
  value = azurerm_public_ip.pip_windows.ip_address
}

output "linux_public_ip" {
  value = azurerm_public_ip.pip_linux.ip_address
}