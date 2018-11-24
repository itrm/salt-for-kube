docker:
  pkg.installed:
    - name: docker.io

  service:
    - running
    - enable: True
    - restart: True
    - require:
      - pkg: docker.io
