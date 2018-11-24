cfssl gencert   -ca=ca.pem   -ca-key=ca-key.pem   -config=ca-config.json   -profile=kubernetes   kubernetes-csr.json | cfssljson -bare kubernetes
cfssl gencert   -ca=ca.pem   -ca-key=ca-key.pem   -config=ca-config.json   -profile=kubernetes   kubernetes-csr.json | cfssljson -bare kubelet-client
cfssl gencert   -ca=ca.pem   -ca-key=ca-key.pem   -config=ca-config.json   -profile=kubernetes   kubernetes-csr.json | cfssljson -bare kube-controller-manager-client
cfssl gencert   -ca=ca.pem   -ca-key=ca-key.pem   -config=ca-config.json   -profile=kubernetes   kubernetes-csr.json | cfssljson -bare kube-scheduler-client
cfssl gencert   -ca=ca.pem   -ca-key=ca-key.pem   -config=ca-config.json   -profile=kubernetes   kubernetes-csr.json | cfssljson -bare kube-proxy-client
cfssl gencert   -ca=ca.pem   -ca-key=ca-key.pem   -config=ca-config.json   -profile=kubernetes   kubernetes-csr.json | cfssljson -bare etcd-server
cfssl gencert   -ca=ca.pem   -ca-key=ca-key.pem   -config=ca-config.json   -profile=kubernetes   kubernetes-csr.json | cfssljson -bare etcd-client

cp kubernetes-key.pem /srv/salt/base/_certs/kubernetes/kubernetes-server.key
cp kubernetes.pem /srv/salt/base/_certs/kubernetes/kubernetes-server.crt
cp ca.pem /srv/salt/base/_certs/kubernetes/ca-kubernetes.crt
cp ca-key.pem /srv/salt/base/_certs/kubernetes/ca-kubernetes.key
cp kubelet-client-key.pem /srv/salt/base/_certs/kubernetes/kubelet-client.key
cp kubelet-client.pem /srv/salt/base/_certs/kubernetes/kubelet-client.crt
cp kube-controller-manager-client.pem /srv/salt/base/_certs/kubernetes/kube-controller-manager-client.crt
cp kube-controller-manager-client-key.pem /srv/salt/base/_certs/kubernetes/kube-controller-manager-client.key
cp kube-scheduler-client-key.pem /srv/salt/base/_certs/kubernetes/kube-scheduler-client.key
cp kube-scheduler-client.pem /srv/salt/base/_certs/kubernetes/kube-scheduler-client.crt
cp kube-proxy-client.pem /srv/salt/base/_certs/kubernetes/kube-proxy-client.crt
cp kube-proxy-client-key.pem /srv/salt/base/_certs/kubernetes/kube-proxy-client.key

cp ca.pem /srv/salt/base/_certs/etcd/ca.pem
cp etcd-server.pem /srv/salt/base/_certs/etcd/etcd-server.crt
cp etcd-server-key.pem /srv/salt/base/_certs/etcd/etcd-server.key
cp etcd-client.pem /srv/salt/base/_certs/etcd/etcd-client.crt
cp etcd-client-key.pem /srv/salt/base/_certs/etcd/etcd-client.key

