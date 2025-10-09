# terraform-proxmox-rke2

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_logic"></a> [logic](#requirement\_logic) | 0.1.6 |
| <a name="requirement_proxmox"></a> [proxmox](#requirement\_proxmox) | 0.84.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_null"></a> [null](#provider\_null) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_server"></a> [server](#module\_server) | ./modules/node | n/a |

## Resources

| Name | Type |
|------|------|
| [null_resource.write_kubeconfig](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [random_password.rke2_token](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_san"></a> [additional\_san](#input\_additional\_san) | RKE2 additional SAN | `list(string)` | `[]` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Cluster name | `string` | `"osug-rke"` | no |
| <a name="input_cpu_cores"></a> [cpu\_cores](#input\_cpu\_cores) | CPU count for master nodes | `number` | n/a | yes |
| <a name="input_cpu_type"></a> [cpu\_type](#input\_cpu\_type) | CPU type | `string` | `"x86-64-v2-AES"` | no |
| <a name="input_datastore"></a> [datastore](#input\_datastore) | The Proxmox datastore id | `string` | n/a | yes |
| <a name="input_disk_full_clone"></a> [disk\_full\_clone](#input\_disk\_full\_clone) | Full clone disk | `bool` | `false` | no |
| <a name="input_disk_size"></a> [disk\_size](#input\_disk\_size) | Master nodes disk size | `number` | n/a | yes |
| <a name="input_dns_server_list"></a> [dns\_server\_list](#input\_dns\_server\_list) | The list of DNS servers to configure on a virtual machine. | `list(string)` | n/a | yes |
| <a name="input_domain"></a> [domain](#input\_domain) | A list of DNS search domains to add to the DNS configuration on the virtual machine | `string` | n/a | yes |
| <a name="input_ha"></a> [ha](#input\_ha) | Setup HA for this nodes | `bool` | `false` | no |
| <a name="input_ipv4_gateway"></a> [ipv4\_gateway](#input\_ipv4\_gateway) | The IPv4 default gateway | `string` | n/a | yes |
| <a name="input_ipv4_netmask"></a> [ipv4\_netmask](#input\_ipv4\_netmask) | The IPV4 subnet mask in bits (e.g. 24 for 255.255.255.0) | `number` | n/a | yes |
| <a name="input_manifests_gzb64"></a> [manifests\_gzb64](#input\_manifests\_gzb64) | RKE2 addons manifests in gz+b64 in the form { "addon\_name": "gzb64\_manifests" } | `map(string)` | `{}` | no |
| <a name="input_manifests_path"></a> [manifests\_path](#input\_manifests\_path) | RKE2 addons manifests directory | `string` | `""` | no |
| <a name="input_memory"></a> [memory](#input\_memory) | Memory count for master nodes | `number` | n/a | yes |
| <a name="input_network_bridge"></a> [network\_bridge](#input\_network\_bridge) | The Proxmox network bridge | `string` | n/a | yes |
| <a name="input_node_name"></a> [node\_name](#input\_node\_name) | The Proxmox Node Name | `string` | `""` | no |
| <a name="input_nodes_count"></a> [nodes\_count](#input\_nodes\_count) | Number of nodes. Conflicts with server\_ip\_list. | `number` | `0` | no |
| <a name="input_pool"></a> [pool](#input\_pool) | The Proxmox resource pool name | `string` | `""` | no |
| <a name="input_registries_conf"></a> [registries\_conf](#input\_registries\_conf) | Containerd registries config in gz+b64 | `string` | `""` | no |
| <a name="input_rke2_config_file"></a> [rke2\_config\_file](#input\_rke2\_config\_file) | RKE2 config file for servers | `string` | `""` | no |
| <a name="input_rke2_version"></a> [rke2\_version](#input\_rke2\_version) | RKE2 version | `string` | `""` | no |
| <a name="input_server_ip_list"></a> [server\_ip\_list](#input\_server\_ip\_list) | A list of nodes IP | `list(string)` | `[]` | no |
| <a name="input_snippets_datastore"></a> [snippets\_datastore](#input\_snippets\_datastore) | The Proxmox datastore id for snippets (cloud-config files) | `string` | n/a | yes |
| <a name="input_system_user"></a> [system\_user](#input\_system\_user) | Default OS image user | `string` | `"ubuntu"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A list of tags to add to nodes | `list(string)` | `[]` | no |
| <a name="input_template_vm"></a> [template\_vm](#input\_template\_vm) | The VM template | `string` | n/a | yes |
| <a name="input_template_vm_node"></a> [template\_vm\_node](#input\_template\_vm\_node) | The VM template node | `string` | n/a | yes |
| <a name="input_write_kubeconfig"></a> [write\_kubeconfig](#input\_write\_kubeconfig) | Write kubeconfig. Use ssh-agent. Needs to be able to SSH to the nodes | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_node_config"></a> [node\_config](#output\_node\_config) | Nodes config |
<!-- END_TF_DOCS -->
