environment     = "staging"
base_image_path = "/var/lib/libvirt/images/ubuntu-22.04-server-cloudimg-amd64.img"
network_cidr    = "192.168.60.0/24"
allowed_ports   = [22, 80]
enable_https    = false

vms = {
  web = {
    hostname = "web-staging"
    memory   = 1024
    vcpu     = 1
  }

  db = {
    hostname = "db-staging"
    memory   = 1024
    vcpu     = 1
  }
}
