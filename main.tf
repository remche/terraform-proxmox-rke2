locals {
  node_config = {
    bootstrap_server = var.server_ip_list[0]
    cluster_name     = var.cluster_name
    datastore_id     = var.datastore
    dns_server_list  = var.dns_server_list
    domain           = var.domain
    ipv4_gateway     = var.ipv4_gateway
    ipv4_netmask     = var.ipv4_netmask
    network_bridge   = var.network_bridge
    pool             = var.pool
    rke2_version     = var.rke2_version
    rke2_token       = random_password.rke2_token.result
    registries_conf  = var.registries_conf
  }
  ssh = "ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null"
  scp = "scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null"
  #remote_rke2_yaml = "${var.system_user}@${module.server.floating_ip[0]}:/etc/rancher/rke2/rke2-remote.yaml"
}

resource "random_password" "rke2_token" {
  length = 64
}

module "server" {
  source             = "./modules/node"
  cluster_name       = var.cluster_name
  name_prefix        = "${var.cluster_name}-server"
  ip_list            = var.server_ip_list
  ipv4_netmask       = var.ipv4_netmask
  ipv4_gateway       = var.ipv4_gateway
  dns_server_list    = var.dns_server_list
  domain             = var.domain
  template_vm        = var.template_vm
  num_cpu            = var.server_num_cpu
  disk_full_clone    = var.disk_full_clone
  disk_size          = var.server_disk_size
  memory             = var.server_memory
  pool               = var.pool
  datastore          = var.datastore
  snippets_datastore = var.snippets_datastore
  network_bridge     = var.network_bridge
  rke2_version       = var.rke2_version
  rke2_config_file   = var.rke2_config_file
  registries_conf    = var.registries_conf
  rke2_token         = random_password.rke2_token.result
  additional_san     = var.additional_san
  manifests_path     = var.manifests_path
  manifests_gzb64    = var.manifests_gzb64
  node_name          = var.node_name

}
