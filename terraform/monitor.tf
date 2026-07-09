resource "azurerm_virtual_machine_extension" "ama_linux" {
  name                       = "AzureMonitorLinuxAgent"
  virtual_machine_id         = azurerm_linux_virtual_machine.linuxvm.id
  publisher                  = "Microsoft.Azure.Monitor"
  type                       = "AzureMonitorLinuxAgent"
  type_handler_version       = "1.0"
  auto_upgrade_minor_version = true

  settings = jsonencode({})
}

resource "azurerm_virtual_machine_extension" "ama_windows" {
  name                       = "AzureMonitorWindowsAgent"
  virtual_machine_id         = azurerm_windows_virtual_machine.winvm.id
  publisher                  = "Microsoft.Azure.Monitor"
  type                       = "AzureMonitorWindowsAgent"
  type_handler_version       = "1.0"
  auto_upgrade_minor_version = true

  settings = jsonencode({})
}

resource "azurerm_monitor_data_collection_endpoint" "dce" {
  name                = "dce-${var.prefix}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  kind                = "Linux"
  description         = "Data Collection Endpoint for Azure Monitor Agent"
  tags                = var.tags
}

resource "azurerm_monitor_data_collection_rule" "dcr" {
  name                = "dcr-${var.prefix}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  description = "Basic VM monitoring"

  destinations {
    log_analytics {
      workspace_resource_id = azurerm_log_analytics_workspace.law.id
      name                  = "law-destination"
    }
  }

  data_flow {
    streams = [
      "Microsoft-Heartbeat",
      "Microsoft-Perf",
      "Microsoft-InsightsMetrics"
    ]

    destinations = ["law-destination"]
  }


  data_sources {

    performance_counter {
      name                          = "perf"
      streams                       = ["Microsoft-Perf"]
      sampling_frequency_in_seconds = 60

      counter_specifiers = [
        "\\Processor(_Total)\\% Processor Time",
        "\\Memory\\Available MBytes"
      ]
    }

    extension {
      name           = "insights"
      streams        = ["Microsoft-InsightsMetrics"]
      extension_name = "AzureMonitorLinuxAgent"
    }
  }
}


resource "azurerm_monitor_data_collection_rule_association" "linux_assoc" {
  name                    = "assoc-linux"
  target_resource_id      = azurerm_linux_virtual_machine.linuxvm.id
  data_collection_rule_id = azurerm_monitor_data_collection_rule.dcr.id
}

resource "azurerm_monitor_data_collection_rule_association" "windows_assoc" {
  name                    = "assoc-windows"
  target_resource_id      = azurerm_windows_virtual_machine.winvm.id
  data_collection_rule_id = azurerm_monitor_data_collection_rule.dcr.id
}

