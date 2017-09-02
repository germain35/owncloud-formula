{% from "owncloud/map.jinja" import owncloud_settings with context %}

include:
  - owncloud.install
  - owncloud.config
  - owncloud.service
