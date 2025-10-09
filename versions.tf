terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.84.1"
    }
    logic = {
      source  = "logicorg/logic"
      version = "0.1.6"
    }
  }
}
