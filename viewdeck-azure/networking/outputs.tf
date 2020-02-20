

# OUTPUTS USEFUL FOR OTHERS MODULES


output "subnet_database_id" {
  value       = "${azurerm_subnet.database.id}"
  description = "SubnetID for database subnet"
}

output "subnet_application_id" {
  value       = "${azurerm_subnet.application.id}"
  description = "SubnetID for application subnet"
}

output "asg_database_id" {
  value       = "${azurerm_application_security_group.database.id}"
  description = "ASG for database subnet"
}

output "asg_application_id" {
  value       = "${azurerm_application_security_group.application.id}"
  description = "ASG for database subnet"
}

# output "subnet-dr_id" {
#   value       = "${azurerm_subnet.subnet-dr.id}"
#   description = "SubnetID for database subnet"
# }