# Remove the Azure Keyvault extension. Will not remove the certificates from the VM
Param(
    $VMName,
    $ResourceGroupName,
    $extName = "KeyVaultForWindows"
)

Remove-AzVmExtension `
    -ResourceGroupName $ResourceGroupName `
    -VMName $VMname `
    -Name $extName