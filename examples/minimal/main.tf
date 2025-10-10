module "controlplane" {
  source = "./../.."
  # source           = "remche/rke2/proxmox"
  cluster_name     = var.cluster_name
  write_kubeconfig = true
  template_vm      = var.template_vm
  server_ip_list   = var.server_ip_list
  ipv4_gateway     = var.ipv4_gateway
  ipv4_netmask     = var.ipv4_netmask
  node_name        = var.node_name
}
