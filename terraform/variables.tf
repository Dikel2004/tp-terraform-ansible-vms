variable "environment" {
  description = "Nom simple du projet."
  type        = string
  default     = "niveau1"
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
  default     = "192.168.60.0/24"
}

variable "vms" {
  description = "Configuration des VMs."
  type = map(object({
    hostname = string
    memory   = number
    vcpu     = number
  }))

  default = {
    web = {
      hostname = "web"
      memory   = 1024
      vcpu     = 1
    }

    db = {
      hostname = "db"
      memory   = 1024
      vcpu     = 1
    }
  }
}
