output "application_ip_address" {
  value       = "${azurerm_public_ip.application.ip_address}"
  description = "IP Address for connection"
}