
variable "resource_group" {
  description = "The name for the virtual network."
  default     = "rg"
}

variable "location" {
  description = "The location/region where the virtual network is created. Changing this forces a new resource to be created."
  default     = "uksouth"
}

variable "virtual_network_name" {
  description = "The name for the virtual network."
  default     = "vnet"
}

variable "address_space" {
  description = "The address space that is used by the virtual network. Changing this forces a new resource to be created."
  default     = "10.0.0.0/22"
}

variable "subnet_database" {
  description = "The address prefix to use for the subnet."
  default     = "10.0.1.0/24"
}

variable "subnet_application" {
  description = "The address prefix to use for the subnet."
  default     = "10.0.3.0/24"
}

# DR

# variable "resource_group_dr" {
#   description = "The name for the virtual network."
#   default     = "rg"
# }

# variable "location_dr" {
#   description = "The location/region where the virtual network is created. Changing this forces a new resource to be created."
#   default     = "uksouth"
# }

# variable "virtual_network_name_dr" {
#   description = "The name for the virtual network."
#   default     = "vnet"
# }

# variable "address_space_dr" {
#   description = "The address space that is used by the virtual network. Changing this forces a new resource to be created."
#   default     = "10.0.0.0/22"
# }

# variable "subnet_dr" {
#   description = "The address prefix to use for the subnet."
#   default     = "10.0.3.0/24"
# }
