{% from "owncloud/map.jinja" import owncloud with context %}

include:
  - owncloud.install
  - owncloud.config
  - owncloud.service
  {%- if owncloud.backup.enabled %}
  - owncloud.backup
  {%- endif %}
