locals {
  project_name = "tp-${var.environment}"
}

resource "libvirt_pool" "project" {
  name = local.project_name
  type = "dir"
  path = "/var/lib/libvirt/images/${local.project_name}"
}

resource "libvirt_volume" "base" {
  name   = "${local.project_name}-base.qcow2"
  pool   = libvirt_pool.project.name
  source = var.base_image_path
  format = "qcow2"
}

resource "libvirt_volume" "vm_disk" {
  for_each       = var.vms
  name           = "${local.project_name}-${each.key}.qcow2"
  pool           = libvirt_pool.project.name
  base_volume_id = libvirt_volume.base.id
  size           = 10 * 1024 * 1024 * 1024
}

resource "libvirt_network" "private" {
  name      = "${local.project_name}-network"
  mode      = "nat"
  addresses = [var.network_cidr]
}

resource "libvirt_cloudinit_disk" "cloudinit" {
  for_each = var.vms
  name     = "${local.project_name}-${each.key}-cloudinit.iso"
  pool     = libvirt_pool.project.name

  user_data = "#cloud-config\n${yamlencode({
    hostname = each.value.hostname
    users = [
      {
        name                = var.vm_user
        sudo                = "ALL=(ALL) NOPASSWD:ALL"
        shell               = "/bin/bash"
        ssh_authorized_keys = [trimspace(file(pathexpand(var.ssh_public_key_path)))]
      }
    ]
  })}"
}

resource "libvirt_domain" "vm" {
  for_each = var.vms

  name   = "${local.project_name}-${each.key}"
  memory = each.value.memory
  vcpu   = each.value.vcpu

  cloudinit = libvirt_cloudinit_disk.cloudinit[each.key].id

  network_interface {
    network_id     = libvirt_network.private.id
    wait_for_lease = true
  }

  disk {
    volume_id = libvirt_volume.vm_disk[each.key].id
  }

  console {
    type        = "pty"
    target_type = "serial"
    target_port = "0"
  }
}

resource "local_file" "ansible_inventory" {
  filename = "${path.module}/../ansible/inventory.ini"
  content = templatefile("${path.module}/templates/inventory.ini.tftpl", {
    vm_user = var.vm_user
    web_ip  = libvirt_domain.vm["web"].network_interface[0].addresses[0]
    db_ip   = libvirt_domain.vm["db"].network_interface[0].addresses[0]
  })
}
