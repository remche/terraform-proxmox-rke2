terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.111.1"
    }
  }
  required_version = "~> 1.15"
}

provider "proxmox" {
  random_vm_ids      = var.random_vm_ids
  random_vm_id_start = var.random_vm_id_start
  random_vm_id_end   = var.random_vm_id_end
}
