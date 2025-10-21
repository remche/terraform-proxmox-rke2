terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.85.1"
    }
    null = {
      source  = "hashicorp/null"
      version = "3.2.4"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.7.2"
    }
  }
  required_version = "1.10.6"
}

provider "proxmox" {
  random_vm_ids      = var.random_vm_ids
  random_vm_id_start = var.random_vm_id_start
  random_vm_id_end   = var.random_vm_id_end
}
