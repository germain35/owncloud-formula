owncloud:
  version: 10.0
  manage_deps: True
  data_dir: /users/owncloud/data
  database:
    type: mysql
    host: localhost
    name: owncloud
    user: owncloud
    password: stupidpassword
  trusted_domains:
    - owncloud.domain.com
