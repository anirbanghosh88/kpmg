resource "azurerm_storage_account" "appvmextnstore1" {
  name                     = "appvmextnstore1"
  resource_group_name      = azurerm_resource_group.apprg.name
  location                 = azurerm_resource_group.apprg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "appvmcont" {
  name                  = "appvmcont"
  storage_account_name  = azurerm_storage_account.appvmextnstore1.name
  container_access_type = "blob"
}
resource "azurerm_storage_blob" "iisconfig" {
  name                   = "iisconfig.ps1"
  storage_account_name   = azurerm_storage_account.appvmextnstore1.name
  storage_container_name = azurerm_storage_container.appvmcont.name
  type                   = "Block"
  source                 = "iisconfig.ps1"
}

resource "azurerm_virtual_machine_extension" "vmextension1" {
  name                 = "vmextension"
  virtual_machine_id   = azurerm_windows_virtual_machine.vm1.id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.10"

  settings = <<SETTINGS
    {
        "fileUris": ["https://${azurerm_storage_account.appvmextnstore1.name}.blob.core.windows.net/${azurerm_storage_container.appvmcont.name}/${azurerm_storage_blob.iisconfig.name}"],
        "commandToExecute": "powershell -ExecutionPolicy Unrestricted -file iisconfig.ps1"
    }
SETTINGS
}

resource "azurerm_virtual_machine_extension" "vmextension2" {
  name                 = "vmextension"
  virtual_machine_id   = azurerm_windows_virtual_machine.vm2.id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.10"

  settings = <<SETTINGS
    {
        "fileUris": ["https://${azurerm_storage_account.appvmextnstore1.name}.blob.core.windows.net/${azurerm_storage_container.appvmcont.name}/${azurerm_storage_blob.iisconfig.name}"],
        "commandToExecute": "powershell -ExecutionPolicy Unrestricted -file iisconfig.ps1"
    }
SETTINGS
}
