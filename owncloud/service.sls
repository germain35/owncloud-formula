{% from "owncloud/map.jinja" import owncloud with context %}

include:
  - owncloud.install

owncloud_service:
  service.running:
    - name: {{ owncloud.service }}
    - enable: True
    - require:
      - pkg: owncloud_packages
