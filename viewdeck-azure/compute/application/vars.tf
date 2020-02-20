variable "resource_group" {
  description = "The name of the resource group in which to create the virtual network."
  #default     = "customerCompany"
}

variable "hostname" {
  description = "VM name referenced also in storage-related names."
  #default     = "vm"
}

variable "subnetid" {
  description = "The subnet to be used. Changing this forces a new resource to be created."
}

variable "asgid" {
  description = "The ASG ID to be used. Changing this forces a new resource to be created."
}

variable "lb_ip_dns_name" {
  description = "DNS for Load Balancer IP"
  #default     = "lbapp2"
}

variable "location" {
  description = "The location/region where the virtual network is created. Changing this forces a new resource to be created."
  #default     = "uksouth"
}


# VM 
variable "vm_size" {
  description = "Specifies the size of the virtual machine."
  #default     = "Standard_D4s_v3"
}

variable "image_sku" {
  description = "the name of the rg for managed image"
  #default = "2016-Datacenter"
}

variable "image_disktype" {
  description = "the name of the rg for managed image"
  #default = "Standard_LRS"
}

variable "datadisk-apps_disktype" {
  description = "the name of the rg for managed image"
  #default = "Standard_LRS"
}

variable "datadisk-apps_size" {
  description = "the name of the rg for managed image"
  #default = "100"
}

variable "admin_username" {
  description = "administrator user name"
  #default     = "vmadmin"
}

variable "admin_password" {
  description = "administrator password (recommended to disable password auth)"
  #default     = "T3rr4F0rmP4ss0n3W0rd"
}

# variable "chef_environment" {
#   description = "chef-solo runlist"
# }

# variable "chef_server_url" {
#   description = "chef-solo runlist"
# }

# variable "chef_server_ip" {
#   description = "chef-solo runlist"
# }

# variable "chef_validation_client_name" {
#   description = "chef-solo runlist"
# }

# variable "chef_validation_secret" {
#   description = "chef-solo runlist"
# }

# variable "runlist" {
#   description = "chef-solo runlist"
# }