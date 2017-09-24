{% from "owncloud/map.jinja" import owncloud_settings with context %}

{%- set os         = salt['grains.get']('os') %}
{%- set os_family  = salt['grains.get']('os_family') %}
{%- set osrelease  = salt['grains.get']('osrelease') %}
{%- set oscodename = salt['grains.get']('oscodename') %}

include:
  - owncloud.install
  - owncloud.service

owncloud_data_dir:
  file.directory:
    - name: {{owncloud_settings.data_dir}}
    - user: {{owncloud_settings.user.name}}
    - group: {{owncloud_settings.user.group}}
    - mode: 775
    - require:
      - sls: owncloud.install
    - watch_in:
      - service: owncloud_service

#owncloud_config:
#  file.managed:
#    - name: {{owncloud_settings.config_file}}
#    - source: salt://owncloud/templates/config.php.jinja2
#    - template: jinja
#    - user: {{owncloud_settings.user.name}}
#    - group: {{owncloud_settings.user.group}}
#    - mode: 640
#    - require:
#      - sls: owncloud.install
#      - file: owncloud_data_dir
#    - watch_in:
#      - service: owncloud_service
