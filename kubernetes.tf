resource "null_resource" "write_kubeconfig" {
  count = var.write_kubeconfig ? 1 : 0

  connection {
    host  = var.server_ip_list[0]
    user  = var.system_user
    agent = true
  }

  provisioner "remote-exec" {
    inline = ["until (grep ${var.cluster_name} /etc/rancher/rke2/rke2-remote.yaml >/dev/null 2>&1); do echo Waiting for rke2 to start && sleep 10; done;"]
  }

  provisioner "local-exec" {
    command = "${local.scp} ${local.remote_rke2_yaml} rke2.yaml"
  }
}
