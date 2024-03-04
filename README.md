# Azure Keyvault Certificate Deployment to VM
Deploy certificates stored in the Azure KeyVault to an Azure Virtual Machine using the KeyVault for Windows (or Linux) extension.

#### Contents
- README.md
- scripts/
    - Set-AzCertificateExtension.ps1
    - Remove-AzCertificateExtension.ps1
    - config/
        - config-for-system-managed.json
        - config-for-user-assigned.json

### Prerequisite Requirements
1. Virtual Machine must have system-managed identity (or user-managed, although system is recommended) enabled.
2. The identity must have *Key Vault Certificate User* privileges to the Key Vault that stores the certificate(s) you'd like to deploy.

### How to Deploy the Certificate
1. Edit the config file in ./scripts/config/ that you'll be using.
```

```
2. Connect to an Azure cloud shell (PowerShell).
3. Clone this repository.
```
git clone https://github.com/adammgourley/Azure-Keyvault-Certificate-Deployment-to-VM.git
```
4. Change directory and set your variables.
```
Set-Location ".\Azure-Keyvault-Certificate-Deployment-to-VM"

$VM_Name = "Example_VM_Name"
$VM_ResourceGroupName = "Example_RSG_Name"
$VM_Location = "Example_VM_Location"                        # ex: "East US" or "West US 2"
$Config_File = ".\scripts\config\config-for-system-managed.json"    # Change based off your VM identity type
```
5. Run the script.
```
# Execute the function
.\scripts\Set-AzVmCertificateExtension `
    -ConfigFile $Config_File `
    -VMName $VM_Name `
    -Location $VM_Location `
    -ResourceGroupName $VM_ResourceGroupName
```

### How to Uninstall the Extension
1. Connect to an Azure cloud shell (PowerShell)
2. Define variables for which VM you'd like to uninstall the extension on.
```
$VM_Name = "Example_VM_Name"
$VM_ResourceGroupName = "Example_RSG_Name"
```
3. Run the following command.
```
Remove-AzVMExtension `
    -VMName $VM_Name `
    -ResourceGroupName $VM_ResourceGroupName `
    -Name "KeyVaultforWindows"                      # Change this if you named the extension something else. This is the default name
```