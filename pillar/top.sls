base:
  'roles:kube-master':
    - match: grain
    - kube-master

  'roles:kube-node':
    - match: grain
    - kube-node
