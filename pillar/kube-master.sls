linux:
  system:
    name: {{ grains.get('host') }}
    enabled: true

etcd:
  server:
    image: quay.io/coreos/etcd:latest
    enabled: true
    bind:
      host: {{ grains.get('fqdn_ip4')[0] }}
    token: some-token
    members:
    - host: 10.50.50.4
      name: m1
      port: 4001

kubernetes:
  common:
    cluster_domain: kube.example.com
    cluster_name: example
    hyperkube:
      image: gcr.io/google_containers/hyperkube:v1.11.0
    addons:
      dns:
        enabled: true
        replicas: 1
        autoscaler:
          enabled: true
        domain: kube.example.com
        server: 172.12.0.100
        dnsmasq:
          cache-size: 1000
          no-resolv:
          server: 127.0.0.1#10053
          log-facility: "-"
      heapster_influxdb:
        enabled: false
        public_ip: 10.50.50.4
      dashboard:
        enabled: true
        public_ip: 10.50.50.4
        image: k8s.gcr.io/kubernetes-dashboard-amd64:v1.8.3
      helm:
        enabled: false
        tiller_image: gcr.io/kubernetes-helm/tiller:v2.2.3
      netchecker:
        enabled: false
        namespace: netchecker
        port: 80
        interval: 60
        server_image: image
        agent_image: image
        agent_probeurls: "http://ipinfo.io"
      calico_policy:
        enabled: false
        namespace: kube-system
        image: image
      coredns:
        enabled: False
        namespace: kube-system
        image: coredns/coredns:latest
        domain: cluster.local
        server: 172.12.0.100
        etcd:
          operator_image: quay.io/coreos/etcd-operator:v0.5.2
          version: 3.1.8
          base_image: quay.io/coreos/etcd
      externaldns:
        enabled: False
        namespace: kube-system
        image: mirantis/external-dns:latest
        domain: kube.example.com
        provider: coredns
      ingress-nginx:
        enabled: True
        controller_replicas: 2
        controller_image: quay.io/kubernetes-ingress-controller/nginx-ingress-controller:0.20.0
    monitoring:
      backend: prometheus
    cni:
      plugins:
        source: https://github.com/containernetworking/plugins/releases/download/v0.7.1/cni-plugins-amd64-v0.7.1.tgz
        hash: e7e5751d43456f69ea1ed043647e0377

  master:
    admin:
      password: some-password
      username: admin
    auth:
      mode: Node,RBAC
      basic:
        enabled: true
        user:
          admin:
            password: some-password
            groups:
              - system:admin
    host:
      name: {{ grains.get('host') }}
    apiserver:
      address: {{ grains.get('fqdn_ip4')[0] }}
      secure_port: 6443
      internal_address: {{ grains.get('fqdn_ip4')[0] }}
      insecure_address: {{ grains.get('fqdn_ip4')[0] }}
      insecure_port: 8080
    ca: kubernetes
    enabled: true
    unschedulable: false
    etcd:
      host: 10.50.50.4
      members:
      - host: 10.50.50.4
        name: m1
      name: m1
      token: some-token
      ssl: 
        enabled: true
    kubelet:
      address: 10.50.50.4
      allow_privileged: true
      fail_on_swap: false
    network:
      calico:
        enabled: true
        calicoctl_image: calico/ctl
        cni_image: calico/cni
        image: calico/node
        kube_controllers_image: calico/kube-controllers
        etcd:
          members:
          - host: 10.50.50.4
            port: 4001
          ssl:
            enabled: true
    service_addresses: 172.12.0.0/16
    storage:
      engine: none
    token:
      admin: some-token
      controller_manager: some-token
      dns: some-token
      kube_proxy: some-token
      kubelet: some-token
      logging: some-token
      monitoring: some-token
      scheduler: some-token
    namespace:
      kube-system:
        enabled: true
      netchecker:
        enabled: true
    container: false
    registry:
      host: tcpcloud
    federation:
      enabled: False
      name: federation
      namespace: federation-system
      source: https://dl.k8s.io/v1.6.2/kubernetes-client-linux-amd64.tar.gz
      hash: f8ef17b8b4bb8f6974fa2b3faa992af3c39ad318c30bdfe1efab957361d8bdfe
      service_type: NodePort
      dns_provider: coredns

