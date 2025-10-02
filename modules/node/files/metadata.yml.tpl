instance-id: "${hostname}"
local-hostname: "${hostname}"
network:
  version: 2
  ethernets:
    ens192:
      addresses: [${ip}/${ ip_netmask }]
      gateway4: ${gw}
      dhcp6: false
      nameservers:
        addresses:
	  %{~ for s in dns_servers ~}
          - ${ s }
	  %{~ endfor ~}
      dhcp4: false
      optional: true
