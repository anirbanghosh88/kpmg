resource "azurerm_windows_virtual_machine_scale_set" "vmss1" {
  name                = "vmss1"
  resource_group_name = azurerm_resource_group.webrg.name
  location            = azurerm_resource_group.webrg.location
  sku                 = "Standard_B1s"
  instances           = 2
  admin_username      = "adminuser"
  admin_password      = "Password@1"

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  network_interface {
    name    = "vmss1nic"
    primary = true

    ip_configuration {
      name      = "internal"
      primary   = true
      subnet_id = azurerm_subnet.subnet2.id
      load_balancer_backend_address_pool_ids = [azurerm_lb_backend_address_pool.weblbbep.id]
    }
  }
  extension {
    name                       = "CustomScript"
    publisher                  = "Microsoft.Compute"
    type                       = "CustomScriptExtension"
    type_handler_version       = "1.10"
    auto_upgrade_minor_version = true

    settings = jsonencode({ "fileUris": ["https://${azurerm_storage_account.appvmextnstore1.name}.blob.core.windows.net/${azurerm_storage_container.appvmcont.name}/${azurerm_storage_blob.iisconfig.name}"],
        "commandToExecute": "powershell -ExecutionPolicy Unrestricted -file iisconfig.ps1" })
     }
  tags = local.default_tags
}