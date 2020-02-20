resource "azurerm_resource_group" "primary-rg" {
  name     = "${var.resource_group_name}"
  location = "${var.region}"
}

module "networking" {
  source = "../../../modules/azure/networking"
  
  resource_group            = "${azurerm_resource_group.primary-rg.name}"
  location                  = "${azurerm_resource_group.primary-rg.location}"
  virtual_network_name      = "${var.virtual_network_name}"
  address_space             = "${var.address_space}"
  subnet_database           = "${var.subnet_database}"
  subnet_application        = "${var.subnet_application}"
}

module "database" {
  source = "../../../modules/azure/compute/database"

  resource_group            = "${azurerm_resource_group.primary-rg.name}"
  location                  = "${azurerm_resource_group.primary-rg.location}"

  hostname                  = "${var.database_hostname}"
  vm_size                   = "${var.database_vm_size}"
  lb_ip_dns_name            = "${var.database_lb_ip_dns_name}"
  
  image_sku                 = "${var.database_image_sku}"
  image_disktype            = "${var.database_image_disktype}"
  
  datadisk-db_disktype      = "${var.database_datadisk-db_disktype}"
  datadisk-db_size          = "${var.database_datadisk-db_size}"

  admin_username            = "${var.admin_username}"
  admin_password            = "${var.admin_password}"

  subnetid                  = "${module.networking.subnet_database_id}"
}

module "application" {
  source = "../../../modules/azure/compute/application"
  
  resource_group            = "${azurerm_resource_group.primary-rg.name}"
  location                  = "${azurerm_resource_group.primary-rg.location}"

  hostname                  = "${var.application_hostname}"
  vm_size                   = "${var.application_vm_size}"
  lb_ip_dns_name            = "${var.application_lb_ip_dns_name}"
  
  image_sku                 = "${var.application_image_sku}"
  image_disktype            = "${var.application_image_disktype}"
  
  datadisk-apps_disktype    = "${var.application_datadisk-apps_disktype}"
  datadisk-apps_size        = "${var.application_datadisk-apps_size}"

  admin_username            = "${var.admin_username}"
  admin_password            = "${var.admin_password}"
  
  subnetid                  = "${module.networking.subnet_application_id}"
  asgid                     = "${module.networking.asg_application_id}"
}

module "webserver" {
  source = "../../../modules/azure/compute/application"
  
  resource_group            = "${azurerm_resource_group.primary-rg.name}"
  location                  = "${azurerm_resource_group.primary-rg.location}"

  hostname                  = "${var.webserver_hostname}"
  vm_size                   = "${var.webserver_vm_size}"
  lb_ip_dns_name            = "${var.webserver_lb_ip_dns_name}"
  
  image_sku                 = "${var.webserver_image_sku}"
  image_disktype            = "${var.webserver_image_disktype}"
  
  datadisk-apps_disktype    = "${var.webserver_datadisk-apps_disktype}"
  datadisk-apps_size        = "${var.webserver_datadisk-apps_size}"

  admin_username            = "${var.admin_username}"
  admin_password            = "${var.admin_password}"
  
  subnetid                  = "${module.networking.subnet_application_id}"
  asgid                     = "${module.networking.asg_application_id}"
}