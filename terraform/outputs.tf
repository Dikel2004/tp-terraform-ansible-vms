output "web_ip" {
  description = "Adresse IP de la VM web."
  value       = libvirt_domain.vm["web"].network_interface[0].addresses[0]
}

output "db_ip" {
  description = "Adresse IP de la VM base de donnees."
  value       = libvirt_domain.vm["db"].network_interface[0].addresses[0]
}

output "ansible_inventory" {
  description = "Fichier inventory genere pour Ansible."
  value       = local_file.ansible_inventory.filename
}

output "ansible_environment_vars" {
  description = "Variables d'environnement generees pour Ansible."
  value       = local_file.ansible_environment_vars.filename
}
