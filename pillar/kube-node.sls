linux:
  system:
    name: {{ grains.get('host') }}
    enabled: true

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
        domain: cluster.local
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
        enabled: false
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
    monitoring:
      backend: prometheus
    cni:
      plugins:
        source: https://github.com/containernetworking/plugins/releases/download/v0.7.1/cni-plugins-amd64-v0.7.1.tgz
        hash: e7e5751d43456f69ea1ed043647e0377

  pool:
    address: {{ grains.get('fqdn_ip4')[0] }}
    allow_privileged: true
    ca: kubernetes
    cluster_dns: 172.12.0.100
    cluster_domain: kube.example.com
    container: false
    enabled: true
    kubelet:
      address: 0.0.0.0
      allow_privileged: true
      config: /etc/kubernetes/manifests
      frequency: 5s
      fail_on_swap: false
    apiserver:
      host: m1.kube.example.com
      address: 10.50.50.4
      secure_port: 6443
      internal_address: 10.50.50.4
      insecure_address: 0.0.0.0
      insecure_port: 8080
    etcd:
      members:
      - host: 10.50.50.4
        name: m1
    host:
      name: {{ grains.get('host') }}
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
    token:
      kube_proxy: some-token
      kubelet: some-token

