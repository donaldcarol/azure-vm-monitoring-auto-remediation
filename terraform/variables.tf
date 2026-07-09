variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "westeurope"
}

variable "prefix" {
  description = "Prefix used for resource names"
  type        = string
  default     = "monlab"
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
  default = {
    project     = "azure-vm-monitoring-auto-remediation"
    environment = "lab"
    owner       = "donald"
  }
}

variable "vnet_address_space" {
  description = "VNet address space"
  type        = list(string)
  default     = ["10.20.0.0/16"]
}

variable "subnet_address_prefixes" {
  description = "Subnet address prefixes"
  type        = list(string)
  default     = ["10.20.1.0/24"]
}

variable "allowed_source_ip" {
  description = "Source IP/CIDR allowed for RDP and SSH. For quick lab use '*', but better set your public IP/CIDR."
  type        = string
  default     = "*"
}

variable "windows_vm_size" {
  description = "Windows VM size"
  type        = string
  default     = "Standard_B2s"
}

variable "linux_vm_size" {
  description = "Linux VM size"
  type        = string
  default     = "Standard_B1s"
}

variable "windows_admin_username" {
  description = "Windows admin username"
  type        = string
  default     = "azureadmin"
}

variable "windows_admin_password" {
  description = "Windows admin password"
  type        = string
  sensitive   = true
}

variable "linux_admin_username" {
  description = "Linux admin username"
  type        = string
  default     = "azureadmin"
}

variable "linux_public_key_path" {
  description = "Path to your SSH public key file"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "log_analytics_sku" {
  description = "Log Analytics SKU"
  type        = string
  default     = "PerGB2018"
}

variable "log_retention_days" {
  description = "Log Analytics retention in days"
  type        = number
  default     = 30
}

variable "alert_email_address" {
  description = "Email address for Azure Monitor action group notifications"
  type        = string
}

variable "cpu_alert_threshold" {
  description = "CPU threshold percentage for alerting"
  type        = number
  default     = 80
}