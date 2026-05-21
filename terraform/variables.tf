variable "environment" {
  description = "Nom de l'environnement : staging ou production."
  type        = string
}

variable "libvirt_uri" {
  description = "URI de connexion libvirt."
  type        = string
  default     = "qemu:///system"
}

variable "vm_user" {
  description = "Utilisateur par defaut de l'image cloud."
  type        = string
  default     = "ubuntu"
}

variable "ssh_public_key_path" {
  description = "Chemin de la cle publique SSH utilisee pour acceder aux VMs."
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "base_image_path" {
  description = "Image cloud Ubuntu/Debian locale utilisee comme base."
  type        = string
}

variable "network_cidr" {
  description = "CIDR du reseau commun."
  type        = string
}

variable "allowed_ports" {
  description = "Ports autorises dans l'environnement."
  type        = list(number)
  default     = [22, 80]
}

variable "enable_https" {
  description = "Indique si le HTTPS doit etre prepare."
  type        = bool
  default     = false
}

variable "vms" {
  description = "Configuration des VMs."
  type = map(object({
    hostname = string
    memory   = number
    vcpu     = number
  }))
}
