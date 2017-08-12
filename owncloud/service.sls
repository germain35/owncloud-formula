{% from "owncloud/map.jinja" import owncloud_settings with context %}

include:
  - owncloud.install

owncloud_service:
  service.running:
    - name: {{ owncloud_settings.service }}
    - enable: True
    - require:
      - pkg: owncloud_packages