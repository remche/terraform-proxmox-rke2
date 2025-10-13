terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.85.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.7.2"
    }

  }
  required_version = "1.13.3"
}

provider "proxmox" {
  random_vm_ids      = var.random_vm_ids
  random_vm_id_start = var.random_vm_id_start
  random_vm_id_end   = var.random_vm_id_end
}
