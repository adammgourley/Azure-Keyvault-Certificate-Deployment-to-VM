# Function to add a certificate from an Azure Keyvault (defined in config file) to the virtual machine
Param(
    $ConfigFile,
    $VMName,
    $Location,
    $ResourceGroupName
)

$Settings = Get-Content -Raw "$ConfigFile"
$extName = "KeyVaultForWindows"
$extType = "KeyVaultForWindows"
$extPublisher = "Microsoft.Azure.KeyVault"

Set-AzVmExtension -TypeHandlerVersion "3.0" `
    -ResourceGroupName $ResourceGroupName `
    -Location $Location `
    -VMName $VMName `
    -Publisher $extPublisher `
    -Name $extName `
    -Type $extType `
    -SettingString $Settings