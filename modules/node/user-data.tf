resource "proxmox_virtual_environment_file" "meta_data_cloud_config" {
  count        = length(var.ip_list)
  content_type = "snippets"
  datastore_id = var.snippets_datastore
  node_name    = var.node_name

  source_raw {
    data = templatefile(("${path.module}/files/metadata.yml.tpl"),
      { hostname = "${var.name_prefix}-${format("%03d", count.index + 1)}"
        ip          = var.ip_list[count.index]
        ip_netmask  = var.ipv4_netmask
        gw          = var.ipv4_gateway
        dns_servers = var.dns_server_list
    })

    file_name = "meta-data-cloud-config-${var.name_prefix}-${format("%03d", count.index + 1)}.yaml"
  }
}

resource "proxmox_virtual_environment_file" "user_data_cloud_config" {
  count        = length(var.ip_list)
  content_type = "snippets"
  datastore_id = var.snippets_datastore
  node_name    = var.node_name

  source_raw {
    data = templatefile(("${path.module}/files/cloud-init.yml.tpl"),
      { cluster_name     = var.cluster_name
        bootstrap_server = var.is_server && count.index != 0 ? var.ip_list[0] : var.bootstrap_server
        public_address   = var.ip_list[0]
        rke2_version     = var.rke2_version
        rke2_token       = var.rke2_token
        is_server        = var.is_server
        san              = var.ip_list
        rke2_conf        = var.rke2_config_file != "" ? file(var.rke2_config_file) : ""
        registries_conf  = var.registries_conf
        additional_san   = var.additional_san
        manifests_files = var.manifests_path != "" ? [for f in fileset(var.manifests_path, "*.{yml,yaml}") : [f, base64gzip(file("${var.manifests_path}/${f}"
        ))]] : []
        manifests_gzb64 = var.manifests_gzb64
    })

    file_name = "user-data-cloud-config-${var.name_prefix}-${format("%03d", count.index + 1)}.yaml"
  }
}
