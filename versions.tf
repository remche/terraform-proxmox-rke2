terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.106.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "3.3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.9.0"
    }
  }
  required_version = "~> 1.15"
}

provider "proxmox" {
  random_vm_ids      = var.random_vm_ids
  random_vm_id_start = var.random_vm_id_start
  random_vm_id_end   = var.random_vm_id_end
}
