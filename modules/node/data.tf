locals {
  online_nodes = [for i, v in tolist(data.proxmox_virtual_environment_nodes.nodes.online) : data.proxmox_virtual_environment_nodes.nodes.names[i] if v]
}
data "proxmox_virtual_environment_nodes" "nodes" {}
