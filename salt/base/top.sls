base:
  'roles:kube-master':
    - match: grain
    - docker
    - etcd-ssl
    - etcd
    - kubernetes

  'roles:kube-node':
    - match: grain
    - docker
    - kube-ssl
    - kubernetes
