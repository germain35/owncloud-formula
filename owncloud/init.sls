{% from "owncloud/map.jinja" import owncloud with context %}

include:
  - owncloud.install
  - owncloud.config
  - owncloud.service
