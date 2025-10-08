variable "node_config" {
  type = object({
    bootstrap_server   = string
    cluster_name       = string
    datastore          = string
    snippets_datastore = string
    dns_server_list    = list(string)
    domain             = string
    ipv4_gateway       = string
    ipv4_netmask       = number
    network_bridge     = string
    pool               = string
    rke2_version       = string
    rke2_token         = string
    registries_conf    = string
  })
}

variable "node_name" {
  type    = string
  default = ""
}

variable "tags" {
  type    = list(string)
  default = []
}

variable "name_prefix" {
  type = string
}

variable "num_cpu" {
  type = number
}

variable "memory" {
  type = number
}

variable "disk_size" {
  type = number
}

variable "disk_full_clone" {
  type    = bool
  default = false
}

variable "template_vm" {
  type = string
}

variable "template_vm_node" {
  type = string
}

variable "ip_list" {
  type = list(string)
}

variable "rke2_config_file" {
  type    = string
  default = ""
}
