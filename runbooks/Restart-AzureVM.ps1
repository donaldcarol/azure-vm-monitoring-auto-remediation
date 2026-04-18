param (
    [string]$ResourceGroupName,
    [string]$VMName
)

Write-Output "Starting runbook for VM restart..."

# Autentificare cu Managed Identity
Connect-AzAccount -Identity

# Verificare VM
$vm = Get-AzVM -ResourceGroupName $ResourceGroupName -Name $VMName -ErrorAction SilentlyContinue

if (!$vm) {
    Write-Error "VM not found!"
    exit
}

# Restart VM
Restart-AzVM -ResourceGroupName $ResourceGroupName -Name $VMName -Force

Write-Output "VM restart triggered successfully."