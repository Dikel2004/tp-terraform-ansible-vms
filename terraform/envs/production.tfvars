environment     = "production"
base_image_path = "/var/lib/libvirt/images/ubuntu-22.04-server-cloudimg-amd64.img"
network_cidr    = "192.168.70.0/24"
allowed_ports   = [22, 80, 443]
enable_https    = true

vms = {
  web = {
    hostname = "web-production"
    memory   = 2048
    vcpu     = 2
  }

  db = {
    hostname = "db-production"
    memory   = 2048
    vcpu     = 2
  }
}
