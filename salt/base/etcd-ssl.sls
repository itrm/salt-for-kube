{% for filename in ['ca.pem', 'etcd-server.key', 'etcd-server.crt', 'etcd-client.key', 'etcd-client.crt' ] %}

/var/lib/etcd/{{ filename }}:
  file.managed:
    - source: salt://_certs/etcd/{{ filename }}
    - user: etcd
    - group: root
    - makedirs: true
    - mode: 640

{% endfor %}
