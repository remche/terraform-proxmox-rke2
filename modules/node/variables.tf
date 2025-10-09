variable "cluster_name" {
  type = string
}

variable "name_prefix" {
  type = string
}

variable "datastore" {
  type = string
}

variable "snippets_datastore" {
  type = string
}

variable "node_name" {
  type    = string
  default = ""
}

variable "pool" {
  type    = string
  default = ""
}

variable "tags" {
  type    = list(string)
  default = []
}

variable "ha" {
  type    = bool
  default = false
}

variable "ip_list" {
  type = list(string)
}

variable "ipv4_netmask" {
  type = number
}

variable "network_bridge" {
  type = string
}

variable "ipv4_gateway" {
  type = string
}

variable "dns_server_list" {
  type = list(string)
}

variable "domain" {
  type = string
}

variable "cpu_cores" {
  type = number
}

variable "cpu_type" {
  type = string
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

variable "rke2_version" {
  type = string
}

variable "rke2_config_file" {
  type = string
}

variable "registries_conf" {
  type    = string
  default = ""
}

variable "bootstrap_server" {
  type    = string
  default = ""
}

variable "is_server" {
  type    = bool
  default = true
}

variable "rke2_token" {
  type    = string
  default = ""
}

variable "additional_san" {
  type        = list(string)
  default     = []
  description = "RKE additional SAN"
}

variable "manifests_path" {
  type        = string
  default     = ""
  description = "RKE2 addons manifests directory"
}

variable "manifests_gzb64" {
  type    = map(string)
  default = {}
}
