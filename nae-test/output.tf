output "application_ip_address" {
  value       = "${module.application.application_ip_address}"
  description = "IP Address for connect"
}

# output "database_ip_address" {
#   value       = "${module.database.database_ip_address}"
#   description = "IP Address for connect"
# }