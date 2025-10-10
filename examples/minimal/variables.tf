variable "cluster_name" {
  type    = string
  default = "minimal"
}

variable "node_name" {
  type    = string
  default = "proxmox-node"
}

variable "template_vm" {
  type    = number
  default = 999
}

variable "server_ip_list" {
  type    = list(string)
  default = ["192.168.1.10"]
}

variable "ipv4_gateway" {
  type    = string
  default = "192.168.1.1"
}

variable "ipv4_netmask" {
  type    = number
  default = 24
}
