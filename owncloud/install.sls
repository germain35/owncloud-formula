{% from "owncloud/map.jinja" import owncloud_settings with context %}

{%- set os         = salt['grains.get']('os') %}
{%- set os_family  = salt['grains.get']('os_family') %}
{%- set osrelease  = salt['grains.get']('osrelease') %}
{%- set oscodename = salt['grains.get']('oscodename') %}

include:
  - owncloud.service

{%- if owncloud_settings.manage_repo %}
  {%- if 'repo' in owncloud_settings and owncloud_settings.repo is mapping %}
owncloud_repo:
  pkgrepo.managed:
    {%- for k, v in owncloud_settings.repo.iteritems() %}
    - {{k}}: {{v}}
    {%- endfor %}
    - require_in:
      - pkg: owncloud_packages
  {%- endif %}
{%- endif %}

owncloud_packages:
  pkg.installed:
    - pkgs: {{owncloud_settings.packages}}
    - watch_in:
      - service: owncloud_service
