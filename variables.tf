variable "cluster_name" {
  type        = string
  default     = "osug-rke"
  description = "Cluster name"
}

variable "server_ip_list" {
  type        = list(string)
  description = "A list of nodes IP"
  default     = []
}

variable "nodes_count" {
  type        = number
  default     = 0
  description = "Number of nodes. Conflicts with server_ip_list."
  validation {
    condition     = provider::logic::xor(length(var.server_ip_list) == 0, var.nodes_count == 0)
    error_message = "You must set one and only one of `first` or `second`."
  }
}

variable "ipv4_netmask" {
  type        = number
  description = "The IPV4 subnet mask in bits (e.g. 24 for 255.255.255.0)"
}

variable "ipv4_gateway" {
  type        = string
  description = "The IPv4 default gateway"
}

variable "dns_server_list" {
  type        = list(string)
  description = " The list of DNS servers to configure on a virtual machine. "
}

variable "domain" {
  type        = string
  description = "A list of DNS search domains to add to the DNS configuration on the virtual machine"
}

variable "node_name" {
  type        = string
  description = "The Proxmox Node Name"
  default     = ""
}

variable "datastore" {
  type        = string
  description = "The Proxmox datastore id"
}

variable "snippets_datastore" {
  type        = string
  description = "The Proxmox datastore id for snippets (cloud-config files)"
}

variable "pool" {
  type        = string
  default     = ""
  description = "The Proxmox resource pool name"
}

variable "tags" {
  type        = list(string)
  description = "A list of tags to add to nodes"
  default     = []
}

variable "ha" {
  type        = bool
  description = "Setup HA for this nodes"
  default     = false
}

variable "network_bridge" {
  type        = string
  description = "The Proxmox network bridge"
}

variable "template_vm" {
  type        = string
  description = "The VM template"
}

variable "template_vm_node" {
  type        = string
  description = "The VM template node"
}

variable "system_user" {
  type        = string
  default     = "ubuntu"
  description = "Default OS image user"
}

variable "cpu_type" {
  type        = string
  description = "CPU type"
  default     = "x86-64-v2-AES"
}

variable "cpu_cores" {
  type        = number
  description = "CPU count for master nodes"
}

variable "memory" {
  type        = number
  description = "Memory count for master nodes"
}

variable "disk_size" {
  type        = number
  description = "Master nodes disk size"
}

variable "disk_full_clone" {
  type        = bool
  default     = false
  description = "Full clone disk"
}

variable "rke2_version" {
  type        = string
  default     = ""
  description = "RKE2 version"
}

variable "rke2_config_file" {
  type        = string
  default     = ""
  description = "RKE2 config file for servers"
}

variable "registries_conf" {
  type        = string
  default     = ""
  description = "Containerd registries config in gz+b64"
}

variable "additional_san" {
  type        = list(string)
  default     = []
  description = "RKE2 additional SAN"
}

variable "manifests_path" {
  type        = string
  default     = ""
  description = "RKE2 addons manifests directory"
}

variable "manifests_gzb64" {
  type        = map(string)
  default     = {}
  description = "RKE2 addons manifests in gz+b64 in the form { \"addon_name\": \"gzb64_manifests\" }"
}

variable "write_kubeconfig" {
  type        = bool
  default     = false
  description = "Write kubeconfig. Use ssh-agent. Needs to be able to SSH to the nodes"
}
