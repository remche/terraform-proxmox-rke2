# terraform-openstack-rke2
[![Terraform Registry](https://img.shields.io/badge/terraform-registry-blue.svg)](https://registry.terraform.io/modules/remche/rke2/proxmox)


[Terraform](https://www.terraform.io/) module to deploy [Kubernetes](https://kubernetes.io) with [RKE2](https://docs.rke2.io/) on [Proxmox](https://www.proxmox.com/) with the help of [bgp/proxmox](https://registry.terraform.io/providers/bpg/proxmox/) provider.

## Prerequisites

- [Terraform](https://www.terraform.io/) or [OpenTofu](https://opentofu.org/)
- [Proxmox](https://www.proxmox.com/) environment properly sourced. See [bpg/proxmox](https://registry.terraform.io/providers/bpg/proxmox/latest/docs#environment-variables-summary) for details, especially the [SSH Connection](https://registry.terraform.io/providers/bpg/proxmox/latest/docs#ssh-connection) section as this module relies on snippets for *cloud-init* data.
- A VM image fullfiling [RKE2 requirements](https://docs.rke2.io/install/requirements/) and featuring curl

## Features

- HA controlplane
- Multiple agent node pools
- Upgrade mechanism

## Documentation

See [USAGE.md](USAGE.md) for all available options.

### How-to

Define controlplane and as many worker pools as you want. Example below configures a control plane with three servers and a single worker pool with three servers.

```hcl
module "controlplane" {
  source             = "./.."
  cluster_name       = mycluster
  template_vm        = "118"
  template_vm_node   = "proxmox-node"
  pool               = "pool-osug"
  datastore          = "vm-datastore"
  snippets_datastore = "cephfs-iso"
  ipv4_netmask       = 24
  ipv4_gateway       = "10.42.0.1"
  dns_server_list    = ["9.9.9.9"]
  domain             = "mydomain.local"
  server_ip_list     = ["10.0.42.2", "10.0.42.3", "10.0.42.4"]
  cpu_cores            = 2
  memory             = 4096
  disk_size          = 48
  network_bridge     = "vmbr0"
  tags               = [var.cluster_name, "kubernetes", "server"]
  ha                 = true
  write_kubeconfig   = true
  random_vm_id_start = 99000
}

module "worker_nodes" {
  source           = "./..//modules/agent"
  template_vm      = "118"
  template_vm_node = "proxmox_node"
  name_prefix      = "worker"
  ip_list          = ["10.0.42.5", "10.0.42.6", "10.0.42.7"]
  cpu_cores        = 2
  memory           = 2048
  disk_size        = 64
  tags             = [var.cluster_name, "kubernetes", "worker"]
  # Required to pass controlplane config to worker pools
  node_config      = module.controlplane.node_config
}
```

### Proxmox nodes

If you don't specify Proxmox nodes, the module will spread the VM randomly on all available nodes.

### VM IDs

To avoid [race condition](https://registry.terraform.io/providers/bpg/proxmox/latest/docs#vm-and-container-id-assignment) when creating vm, the module uses random VM IDs. You can disable this features via `random_vm_ids` variable or set the VM IDs range via `random_vm_ids_start` and `random_vm_ids_end` variables.

### Kubernetes version

You can specify rke2 version with `rke2_version` variables. Refer to RKE2 supported version.

Upgrade by setting the target version via `rke2_version` and `do_upgrade = true`. It will upgrade the nodes one-by-one, server nodes first.

> [!WARNING]
> In-place upgrade mechanism is not battle-tested and relies on Terraform provisioners.

### Addons

Set the `manifests_path` variable to point out the directory containing your [manifests and HelmChart](https://docs.rke2.io/helm.html#automatically-deploying-manifests-and-helm-charts) (see [JupyterHub example](./examples/jupyterhub/)).

If you need a template step for your manifests, you can use `manifests_gzb64`.

> [!WARNING]
> Modifications made to manifests after cluster deployement wont have any effect.

### Additional server config files
Set the `additional_configs_path` variable to the directory containing your additional rke2 server configs.

If you need a template step for your config files, you can use `additional_configs_gzb64`.

> [!WARNING]
> Modifications made to manifests after cluster deployement wont have any effect.

### Downscale

You need to manually drain and remove node before downscaling a pool nodes.
