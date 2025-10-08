resource "proxmox_virtual_environment_vm" "vm" {
  count     = length(var.ip_list)
  name      = "${var.name_prefix}-${format("%03d", count.index + 1)}"
  tags      = var.tags
  node_name = var.node_name
  pool_id   = var.pool 

  cpu {
    cores = var.num_cpu
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

  disk {
    datastore_id = var.datastore
    interface    = "scsi0"
    size         = var.disk_size
  }

  clone {
    vm_id = var.template_vm
    full  = var.disk_full_clone
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

  # lifecycle {
  #   ignore_changes = [
  #     extra_config
  #   ]
  # }
}
