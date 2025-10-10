# terraform-openstack-rke2
[![Terraform Registry](https://img.shields.io/badge/terraform-registry-blue.svg)](https://registry.terraform.io/modules/remche/rke2/proxmox)


[Terraform](https://www.terraform.io/) module to deploy [Kubernetes](https://kubernetes.io) with [RKE2](https://docs.rke2.io/) on [Proxmox](https://www.proxmox.com/) with the help of [bgp/proxmox](https://registry.terraform.io/providers/bpg/proxmox/) provider.

## Prerequisites

- [Terraform](https://www.terraform.io/) or [OpenTofu](https://opentofu.org/)
- [Proxmox](https://www.proxmox.com/) environment properly sourced. See [bpg/proxmox](https://registry.terraform.io/providers/bpg/proxmox/latest/docs#environment-variables-summary) for details.
- A VM image fullfiling [RKE2 requirements](https://docs.rke2.io/install/requirements/) and featuring curl

## Features

- HA controlplane
- Multiple agent node pools
- Upgrade mechanism

## Documentation

See [USAGE.md](USAGE.md) for all available options.

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
