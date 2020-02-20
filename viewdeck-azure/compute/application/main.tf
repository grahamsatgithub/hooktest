
resource "azurerm_availability_set" "application" {
  name                         = "${var.lb_ip_dns_name}-avset"
  location                     = "${var.location}"
  resource_group_name          = "${var.resource_group}"
  platform_fault_domain_count  = 2
  platform_update_domain_count = 5
  managed                      = true
}

resource "azurerm_public_ip" "application" {
  name                = "${var.lb_ip_dns_name}-ip"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group}"
  allocation_method   = "Static"
  domain_name_label   = "${var.lb_ip_dns_name}"
}

resource "azurerm_lb" "application" {
  resource_group_name = "${var.resource_group}"
  name                = "${var.lb_ip_dns_name}-lb"
  location            = "${var.location}"

  frontend_ip_configuration {
    name                 = "LoadBalancerFrontEnd"
    public_ip_address_id = "${azurerm_public_ip.application.id}"
  }
}

resource "azurerm_lb_backend_address_pool" "application" {
  resource_group_name = "${var.resource_group}"
  loadbalancer_id     = "${azurerm_lb.application.id}"
  name                = "appBackendPool1"
}

resource "azurerm_lb_nat_rule" "application-rdp" {
  resource_group_name            = "${var.resource_group}"
  loadbalancer_id                = "${azurerm_lb.application.id}"
  name                           = "RDP-VM"
  protocol                       = "tcp"
  frontend_port                  = "50001"
  backend_port                   = 3389
  frontend_ip_configuration_name = "LoadBalancerFrontEnd"
}

resource "azurerm_lb_rule" "application" {
  resource_group_name            = "${var.resource_group}"
  loadbalancer_id                = "${azurerm_lb.application.id}"
  name                           = "LBRule"
  protocol                       = "tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "LoadBalancerFrontEnd"
  enable_floating_ip             = false
  backend_address_pool_id        = "${azurerm_lb_backend_address_pool.application.id}"
  idle_timeout_in_minutes        = 5
  probe_id                       = "${azurerm_lb_probe.application.id}"
  depends_on                     = ["azurerm_lb_probe.application"]
}

resource "azurerm_lb_probe" "application" {
  resource_group_name = "${var.resource_group}"
  loadbalancer_id     = "${azurerm_lb.application.id}"
  name                = "tcpProbe"
  protocol            = "tcp"
  port                = 80
  interval_in_seconds = 5
  number_of_probes    = 2
}

resource "azurerm_network_interface" "application" {
  name                = "${var.hostname}-nic"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group}"

  ip_configuration {
    name                          = "ipconfig"
    subnet_id                     = "${var.subnetid}"
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface_backend_address_pool_association" "application" {
  network_interface_id    = "${azurerm_network_interface.application.id}"
  ip_configuration_name   = "ipconfig"
  backend_address_pool_id = "${azurerm_lb_backend_address_pool.application.id}"
}

resource "azurerm_network_interface_nat_rule_association" "application-tcpnatrule" {
  network_interface_id  = "${azurerm_network_interface.application.id}"
  ip_configuration_name = "ipconfig"
  nat_rule_id           = "${azurerm_lb_nat_rule.application-rdp.id}"
}

resource "azurerm_network_interface_application_security_group_association" "application" {
  network_interface_id          = "${azurerm_network_interface.application.id}"
  ip_configuration_name         = "ipconfig"
  application_security_group_id = "${var.asgid}"
}

resource "azurerm_virtual_machine" "application" {
  name                  = "${var.hostname}"
  location              = "${var.location}"
  resource_group_name   = "${var.resource_group}"
  availability_set_id   = "${azurerm_availability_set.application.id}"
  vm_size               = "${var.vm_size}"
  network_interface_ids = ["${azurerm_network_interface.application.id}"]

  storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "${var.image_sku}"
    version   = "latest"
  }

  storage_os_disk {
    name              = "${var.hostname}-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "${var.image_disktype}"
  }

  os_profile {
    computer_name  = "${var.hostname}"
    admin_username = "${var.admin_username}"
    admin_password = "${var.admin_password}"
  }

  delete_os_disk_on_termination = true
  delete_data_disks_on_termination = true


  os_profile_windows_config {
    provision_vm_agent = true
    winrm {
      protocol = "http"
      certificate_url =""
    }
  }
}

# resource "azurerm_virtual_machine_extension" "MoveAzureTempDrive" {
#   name                 = "MoveAzureTempDrive-app"
#   location             = "${var.location}"
#   resource_group_name  = "${var.resource_group}"
#   virtual_machine_name = "${azurerm_virtual_machine.application.name}"
#   publisher            = "Microsoft.Powershell"
#   type                 = "DSC"
#   type_handler_version = "2.73"
#   depends_on           = ["azurerm_virtual_machine.application"]

#   settings = <<SETTINGS
#         {
#             "WmfVersion": "latest",
#             "ModulesUrl": "https://euwestutility.blob.core.windows.net/scripts/MoveAzureTempDrive.ps1.zip",
#             "ConfigurationFunction": "MoveAzureTempDrive.ps1\\MoveAzureTempDrive",
#             "Properties": {
#               "TempDriveLetter" : "T"
#             }
#         }
#     SETTINGS
# }

# resource "azurerm_managed_disk" "datadisk-apps" {
#   name                 = "${var.hostname}-datadisk-apps"
#   location             = "${var.location}"
#   resource_group_name  = "${var.resource_group}"
#   storage_account_type = "${var.datadisk-apps_disktype}"
#   create_option        = "Empty"
#   disk_size_gb         = "${var.datadisk-apps_size}"
# }

# resource "azurerm_virtual_machine_data_disk_attachment" "datadisk-apps" {
#   managed_disk_id    = "${azurerm_managed_disk.datadisk-apps.id}"
#   virtual_machine_id = "${azurerm_virtual_machine.application.id}"
#   lun                = "1"
#   caching            = "ReadWrite"
#   depends_on         = ["azurerm_virtual_machine_extension.MoveAzureTempDrive"]
# }

# resource "azurerm_virtual_machine_extension" "DiskInitialization" {
#   name                 = "DiskInitialization-app"
#   location             = "${var.location}"
#   resource_group_name  = "${var.resource_group}"
#   virtual_machine_name = "${azurerm_virtual_machine.application.name}"
#   publisher            = "Microsoft.Compute"
#   type                 = "CustomScriptExtension"
#   type_handler_version = "1.9"

#   protected_settings = <<PROTECTED_SETTINGS
#     {
#       "commandToExecute": "powershell -ExecutionPolicy Unrestricted -Command \"& { $ErrorActionPreference = 'SilentlyContinue'; Get-WmiObject -Class Win32_volume -Filter 'DriveType=5' | Select-Object -First 1 | Set-WmiInstance -Arguments @{DriveLetter='Z:'}; Get-Disk | Where-Object PartitionStyle –Eq 'RAW' | Initialize-Disk; New-Partition -DiskNumber 2 -UseMaximumSize -DriveLetter D | Format-Volume -FileSystem NTFS -NewFileSystemLabel Apps -Confirm:$false\""
#     } 
#     PROTECTED_SETTINGS
#     depends_on = [
#       "azurerm_virtual_machine_data_disk_attachment.datadisk-apps"
#       ]
# }
