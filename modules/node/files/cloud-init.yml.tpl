#cloud-config
users:
  - default
  - name: ubuntu
    groups:
      - sudo
    shell: /bin/bash
    ssh_authorized_keys:
      - "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAgSFElSJpzGubKOHshlIVJJQ2723zlaJTTLWBIp1S5R remche@peaky"
write_files:
- path: /usr/local/bin/wait-for-node-ready.sh
  permissions: "0755"
  owner: root:root
  content: |
    #!/bin/sh
    until (curl -sL http://localhost:10248/healthz) && [ $(curl -sL http://localhost:10248/healthz) = "ok" ];
      do sleep 10 && echo "Wait for $(hostname) kubelet to be ready"; done;
%{ if bootstrap_server == "" ~}
  %{~ for f in manifests_files ~}
- path: /var/lib/rancher/rke2/server/manifests/${f[0]}.yaml
  permissions: "0600"
  owner: root:root
  encoding: gz+b64
  content: ${f[1]}
  %{~ endfor ~}
  %{~ for k, v in manifests_gzb64 ~}
- path: /var/lib/rancher/rke2/server/manifests/${k}.yaml
  permissions: "0600"
  owner: root:root
  encoding: gz+b64
  content: ${v}
  %{~ endfor ~}
%{~ endif ~}
%{~ if registries_conf != "" ~}
- path: /etc/rancher/rke2/registries.yaml
  permissions: "0600"
  owner: root:root
  encoding: gz+b64
  content: ${registries_conf}
%{ endif ~}
- path: /etc/rancher/rke2/config.yaml
  permissions: "0600"
  owner: root:root
  content: |
    token: "${rke2_token}"
    %{~ if bootstrap_server != "" ~}
    server: https://${bootstrap_server}:9345
    %{~ endif ~}
    %{~ if is_server ~}

    write-kubeconfig-mode: "0640"
    tls-san:
      ${indent(6, yamlencode(concat(san, additional_san)))}
    kube-apiserver-arg: "kubelet-preferred-address-types=InternalIP,ExternalIP,Hostname"
    %{~ endif ~}
    ${indent(4,rke2_conf)}
runcmd:
  - export INSTALL_RKE2_VERSION=${rke2_version}
  - curl -sfL https://get.rke2.io | sh -
  %{~ if is_server ~}
    %{~ if bootstrap_server != "" ~}
  - [ sh,  -c, 'until (nc -z ${bootstrap_server} 6443); do echo Wait for master node && sleep 10; done;']
    %{~ endif ~}
  - systemctl enable rke2-server.service
  - systemctl start rke2-server.service
  - [ sh, -c, 'until [ -f /etc/rancher/rke2/rke2.yaml ]; do echo Waiting for rke2 to start && sleep 10; done;' ]
  - [ sh, -c, 'until [ -x /var/lib/rancher/rke2/bin/kubectl ]; do echo Waiting for kubectl bin && sleep 10; done;' ]
  - cp /etc/rancher/rke2/rke2.yaml /etc/rancher/rke2/rke2-remote.yaml
  - sudo chgrp sudo /etc/rancher/rke2/rke2-remote.yaml
  - KUBECONFIG=/etc/rancher/rke2/rke2-remote.yaml /var/lib/rancher/rke2/bin/kubectl config set-cluster default --server https://${public_address}:6443
  - KUBECONFIG=/etc/rancher/rke2/rke2-remote.yaml /var/lib/rancher/rke2/bin/kubectl config rename-context default ${cluster_name}
  %{~ else ~}
  - systemctl enable rke2-agent.service
  - systemctl start rke2-agent.service
  %{~ endif ~}
