# Azure Keyvault Certificate Deployment to Windows VM
Deploy certificates stored in the Azure KeyVault to an Azure Virtual Machine using the KeyVault for Windows extension. If this extension is removed after it's been deployed, the certificates will not be uninstalled from the server.

<br>

### Prerequisite Requirements
1. Virtual Machine must have a *system-managed identity* (or *user-assigned*, although system is recommended) enabled.
2. The identity must have *Key Vault Certificate User* privileges to the Key Vault that stores the certificate(s) you'd like to deploy.

<br>

### How to Deploy the Certificate
1. Connect to an Azure cloud shell (PowerShell).
2. Clone this repository.
``` powershell
git clone "https://github.com/adammgourley/Azure-Keyvault-Certificate-Deployment-to-VM.git"
```
3. Edit the config file in ./scripts/config/ that you'll be using. Can use the [Microsoft Documentation](https://learn.microsoft.com/en-us/azure/virtual-machines/extensions/key-vault-windows?tabs=version3) for reference.
4. Change directory and set your variables.
``` powershell
Set-Location ".\Azure-Keyvault-Certificate-Deployment-to-VM"

$VM_Name = "Example_VM_Name"
$VM_ResourceGroupName = "Example_RSG_Name"
$VM_Location = "Example_VM_Location"                        # ex: "East US" or "West US 2"
$Config_File = ".\scripts\config\config-for-system-managed.json"    # Change based off your VM identity type
```
5. Run the script.
``` powershell
.\scripts\Set-AzVmCertificateExtension `
    -ConfigFile $Config_File `
    -VMName $VM_Name `
    -Location $VM_Location `
    -ResourceGroupName $VM_ResourceGroupName
```

<br>

### How to Uninstall the Extension
1. Connect to an Azure cloud shell (PowerShell)
2. Define variables for which VM you'd like to uninstall the extension on.
``` powershell
$VM_Name = "Example_VM_Name"
$VM_ResourceGroupName = "Example_RSG_Name"
```
3. Run the following command.
``` powershell
Remove-AzVMExtension `
    -VMName $VM_Name `
    -ResourceGroupName $VM_ResourceGroupName `
    -Name "KeyVaultforWindows"                      # Change this if you named the extension something else. This is the default name
```

<br>

### Troubleshooting
If you receive any errors in the Azure cloud shell, they are likely due to a permission misconfiguration. Ensure you followed the prerequisites correctly.

If you installed the extension without any errors, but the certificate is still not showing as installed, review the log files at the following location on the target VM.
- C:\WindowsAzure\Logs\Plugins\Microsoft.Azure.KeyVault.KeyVaultForWindows

For configuration file issues or questions, you can reference the [Microsoft Documentation](https://learn.microsoft.com/en-us/azure/virtual-machines/extensions/key-vault-windows?tabs=version3).