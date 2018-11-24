{% for filename in ['kubernetes-server.crt', 'kubernetes-server.key', 'kubernetes-server.pem', 'ca-kubernetes.crt', 'ca-kubernetes.key', 'kubelet-client.crt', 'kubelet-client.key', 'kube-controller-manager-client.crt', 'kube-controller-manager-client.key', 'kube-scheduler-client.crt', 'kube-scheduler-client.key', 'kube-proxy-client.crt', 'kube-proxy-client.key'] %}

/etc/kubernetes/ssl/{{ filename }}:
  file.managed:
    - source: salt://_certs/kubernetes/{{ filename }}
    - user: root
    - makedirs: true
    - group: root
    - mode: 640
{% endfor %}
