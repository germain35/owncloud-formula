{% from "owncloud/map.jinja" import owncloud with context %}

{%- set os         = salt['grains.get']('os') %}
{%- set os_family  = salt['grains.get']('os_family') %}
{%- set osrelease  = salt['grains.get']('osrelease') %}
{%- set oscodename = salt['grains.get']('oscodename') %}

include:
  - owncloud.install
  - owncloud.service

owncloud_data_dir:
  file.directory:
    - name: {{owncloud.data_dir}}
    - user: {{owncloud.user.name}}
    - group: {{owncloud.user.group}}
    - mode: 775
    - makedirs: True
    - require:
      - sls: owncloud.install
    - watch_in:
      - service: owncloud_service

#owncloud_config:
#  file.managed:
#    - name: {{owncloud.config_file}}
#    - source: salt://owncloud/templates/config.php.jinja2
#    - template: jinja
#    - user: {{owncloud.user.name}}
#    - group: {{owncloud.user.group}}
#    - mode: 640
#    - require:
#      - sls: owncloud.install
#      - file: owncloud_data_dir
#    - watch_in:
#      - service: owncloud_service
