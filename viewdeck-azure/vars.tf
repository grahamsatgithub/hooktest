variable "application_name" {
  description = "The name of the aplication, this case WordWatch"
}

variable "customer_name" {
  description = "Customer name used to create specific customer resources"
}

variable "short_customer_name" {
  description = "Customer name used to prefix specific customer resources"
}

variable "environment" {
  description = "Environment of customer installation"
}

# Subscription ID:
variable "subscription_id" {
  description = "The subscription ID where the Resource Group and all resources will be created"
}

variable "client_id" {
  description = "This is the appid created on App registration"
}

variable "client_secret" {
  description = "The password for the appid created on the app resgistration process"
}

variable "tenant_id" {
  description = "The tenant ID"
}

variable "resource_group" {
  description = "The name of the resource group in which to create the virtual network."
  default     = "terraform-rg"
}

variable "location" {
  description = "The location/region where the virtual network is created. Changing this forces a new resource to be created."
  default     = "uksouth"
}