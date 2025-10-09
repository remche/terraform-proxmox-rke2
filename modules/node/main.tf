resource "random_integer" "random_nodes" {
  min   = 0
  max   = length(local.online_nodes) - 1
  count = var.node_name == "" ? length(var.ip_list) : 0
}

resource "proxmox_virtual_environment_haresource" "ha" {
  count       = var.ha ? length(var.ip_list) : 0
  resource_id = "vm:${proxmox_virtual_environment_vm.vm[count.index].vm_id}"
}

resource "proxmox_virtual_environment_vm" "vm" {
  count     = length(var.ip_list)
  name      = "${var.name_prefix}-${format("%03d", count.index + 1)}"
  tags      = var.tags
  node_name = var.node_name == "" ? local.online_nodes[count.index] : var.node_name
  pool_id   = var.pool

  cpu {
    cores = var.cpu_cores
    numa  = true
    type  = var.cpu_type
  }

  memory {
    dedicated = var.memory
  }

  agent {
    enabled = true
  }

  stop_on_destroy = true

  network_device {
    bridge = var.network_bridge
  }

  tpm_state {
    datastore_id = var.datastore
  }

  disk {
    datastore_id = var.datastore
    interface    = "scsi0"
    size         = var.disk_size
  }

  clone {
    vm_id     = var.template_vm
    node_name = var.template_vm_node
    full      = var.disk_full_clone
  }

  initialization {
    datastore_id = var.datastore
    dns {
      domain  = var.domain
      servers = var.dns_server_list
    }
    ip_config {
      ipv4 {
        address = "${var.ip_list[count.index]}/${var.ipv4_netmask}"
        gateway = var.ipv4_gateway
      }
    }
    meta_data_file_id = proxmox_virtual_environment_file.meta_data_cloud_config[count.index].id
    user_data_file_id = proxmox_virtual_environment_file.user_data_cloud_config[count.index].id
  }
}
