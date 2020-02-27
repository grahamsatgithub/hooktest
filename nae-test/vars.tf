
variable "application_name" {
  default = "naeapp-test"
}

# Subscription information:
variable "subscription_id" {
  default = "ddefea1d-160c-444b-9272-3e84095eb5d1"
}
variable "client_id" {
  default = "6d29e445-e862-4c4f-b9e5-18cae3ac0411"
}

variable "client_secret" {
  default = "22298809-017c-4208-a52a-515effc6edcf"
}

variable "tenant_id" {
  default = "755a64e1-cb80-45c4-823e-b07b5d5981d5"
}

variable "resource_group_name" {
  default = "test-nae-rg-test"
}

variable "region" {
  default = "uksouth"
}


# VNET VARS

variable "virtual_network_name" {
  default = "test-nae-vnet-test"
}

variable "address_space" {
  default = "10.110.0.0/22"
}

variable "subnet_database" {
  default = "10.110.1.0/24"
}

variable "subnet_application" {
  default = "10.110.2.0/24"
}


# DATABASE VARS

variable "database_hostname" {
  default = "nae-test-db"
}

variable "database_vm_size" {
  default = "Standard_B1ms"
}

variable "database_image_sku" {
  default = "2016-Datacenter"
}

variable "database_image_disktype" {
  default = "Standard_LRS"
}

variable "database_datadisk-apps_disktype" {
  default = "Standard_LRS"
}

variable "database_datadisk-apps_size" {
  default = "300"
}

variable "database_datadisk-db_disktype" {
  default = "Standard_LRS"
}

variable "database_datadisk-db_size" {
  default = "300"
}

variable "database_lb_ip_dns_name" {
  default = "nae-test-db"
}


# APPLICATION VARS

variable "application_hostname" {
  default = "nae-test-app"
}

variable "application_vm_size" {
  default = "Standard_B1ms"
}

variable "application_lb_ip_dns_name" {
  default = "nae-test-app"
}

variable "application_image_sku" {
  default = "2016-Datacenter"
}

variable "application_image_disktype" {
  default = "Standard_LRS"
}

variable "application_datadisk-apps_disktype" {
  default = "Standard_LRS"
}

variable "application_datadisk-apps_size" {
  default = "100"
}

variable "admin_username" {
  default = "vmadmin"
}

variable "admin_password" {
  default = "T3rr4F0rmP4ss0n3W0rd"
}


# WEBSERVER VARS

variable "webserver_hostname" {
  default = "nae-test-websr"
}

variable "webserver_vm_size" {
  default = "Standard_B1ms"
}

variable "webserver_lb_ip_dns_name" {
  default = "nae-test-webserv"
}

variable "webserver_image_sku" {
  default = "2016-Datacenter"
}

variable "webserver_image_disktype" {
  default = "Standard_LRS"
}

variable "webserver_datadisk-apps_disktype" {
  default = "Standard_LRS"
}

variable "webserver_datadisk-apps_size" {
  default = "100"
}
