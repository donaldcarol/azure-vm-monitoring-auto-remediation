resource "azurerm_monitor_action_group" "ag" {
  name                = "ag-${var.prefix}"
  resource_group_name = azurerm_resource_group.rg.name
  short_name          = "monag"

  email_receiver {
    name          = "email-notifications"
    email_address = var.alert_email_address
  }

  tags = var.tags
}

resource "azurerm_monitor_metric_alert" "high_cpu_windows" {
  name                = "alert-${var.prefix}-cpu-win"
  resource_group_name = azurerm_resource_group.rg.name
  scopes              = [azurerm_windows_virtual_machine.winvm.id]
  description         = "Alert when Windows VM CPU is above threshold"
  severity            = 2
  frequency           = "PT1M"
  window_size         = "PT5M"

  criteria {
    metric_namespace = "Microsoft.Compute/virtualMachines"
    metric_name      = "Percentage CPU"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = var.cpu_alert_threshold
  }

  action {
    action_group_id = azurerm_monitor_action_group.ag.id
  }

  tags = var.tags
}

resource "azurerm_monitor_metric_alert" "high_cpu_linux" {
  name                = "alert-${var.prefix}-cpu-linux"
  resource_group_name = azurerm_resource_group.rg.name
  scopes              = [azurerm_linux_virtual_machine.linuxvm.id]
  description         = "Alert when Linux VM CPU is above threshold"
  severity            = 2
  frequency           = "PT1M"
  window_size         = "PT5M"

  criteria {
    metric_namespace = "Microsoft.Compute/virtualMachines"
    metric_name      = "Percentage CPU"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = var.cpu_alert_threshold
  }

  action {
    action_group_id = azurerm_monitor_action_group.ag.id
  }

  tags = var.tags
}

resource "azurerm_monitor_metric_alert" "heartbeat_missing_linux" {
  name                = "alert-${var.prefix}-heartbeat-missing-linux"
  resource_group_name = azurerm_resource_group.rg.name
  scopes              = [azurerm_log_analytics_workspace.law.id]

  description = "Alert when Linux VM heartbeat is missing"
  severity    = 1
  frequency   = "PT1M"
  window_size = "PT5M"

  criteria {
    metric_namespace = "Microsoft.OperationalInsights/workspaces"
    metric_name      = "Heartbeat"
    aggregation      = "Count"
    operator         = "LessThan"
    threshold        = 1

    dimension {
      name     = "Computer"
      operator = "Include"
      values   = ["linuxvm"]
    }
  }

  action {
    action_group_id = azurerm_monitor_action_group.ag.id
  }

  tags = var.tags
}

resource "azurerm_monitor_metric_alert" "heartbeat_missing_windows" {
  name                = "alert-${var.prefix}-heartbeat-missing-win"
  resource_group_name = azurerm_resource_group.rg.name
  scopes              = [azurerm_log_analytics_workspace.law.id]

  description = "Alert when Windows VM heartbeat is missing"
  severity    = 1
  frequency   = "PT1M"
  window_size = "PT5M"

  criteria {
    metric_namespace = "Microsoft.OperationalInsights/workspaces"
    metric_name      = "Heartbeat"
    aggregation      = "Count"
    operator         = "LessThan"
    threshold        = 1

    dimension {
      name     = "Computer"
      operator = "Include"
      values   = ["vm-monlab-win"]
    }
  }

  action {
    action_group_id = azurerm_monitor_action_group.ag.id
  }

  tags = var.tags
}

/* resource "azurerm_monitor_scheduled_query_rules_alert_v2" "heartbeat_missing" {
  name                = "alert-${var.prefix}-heartbeat-missing"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  evaluation_frequency = "PT5M"
  window_duration      = "PT10M"
  scopes               = [azurerm_log_analytics_workspace.law.id]
  severity             = 1
  description          = "Alert when heartbeat is missing for one or more VMs"
  enabled              = true

  criteria {
    query = <<-QUERY
Heartbeat
| summarize LastHeartbeat=max(TimeGenerated) by Computer
| extend MinutesSinceLastHeartbeat = datetime_diff('minute', now(), LastHeartbeat) * -1
| where MinutesSinceLastHeartbeat > 5
    QUERY

    time_aggregation_method = "Count"
    threshold               = 0
    operator                = "GreaterThan"

    failing_periods {
      minimum_failing_periods_to_trigger_alert = 1
      number_of_evaluation_periods             = 1
    }
  }

  action {
    action_groups = [azurerm_monitor_action_group.ag.id]
  }

  tags = var.tags
}
*/