{% from "owncloud/map.jinja" import owncloud with context %}

{%- set os         = salt['grains.get']('os') %}
{%- set os_family  = salt['grains.get']('os_family') %}
{%- set osrelease  = salt['grains.get']('osrelease') %}
{%- set oscodename = salt['grains.get']('oscodename') %}

include:
  - owncloud.service

{%- if owncloud.manage_repo %}
  {%- if 'repo' in owncloud and owncloud.repo is mapping %}
owncloud_repo:
  pkgrepo.managed:
    {%- for k, v in owncloud.repo.iteritems() %}
    - {{k}}: {{v}}
    {%- endfor %}
    - require_in:
      - pkg: owncloud_packages
  {%- endif %}
{%- endif %}

{%- if owncloud.manage_deps %}
owncloud_packages_deps:
  pkg.installed:
    - pkgs: {{owncloud.packages_deps}}
    - require_in:
      - pkg: owncloud_packages
{%- endif %}

owncloud_packages:
  pkg.installed:
    - pkgs: {{owncloud.packages}}
    - watch_in:
      - service: owncloud_service

