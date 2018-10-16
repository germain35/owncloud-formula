{% from "owncloud/map.jinja" import owncloud with context %}

owncloud_backup_packages:
  pkg.installed:
    - pkgs:
      - rsync

owncloud_backup_script:
  file.managed:
    - name: {{ owncloud.backup_script }}
    - source: salt://owncloud/templates/backup.sh.j2
    - template: jinja
    - mode: 755
    - makedirs: True

owncloud_backup_dir:
  file.directory:
    - name: {{ owncloud.backup.dir }}

{%- if owncloud.backup.cron is defined %}
owncloud_backup_log:
  file.managed:
    - name: {{ owncloud.backup_log }}
    - replace: False
    - makedirs: True
    - require:
      - file: owncloud_backup_script

owncloud_backup_cron:
  cron.present:
    - identifier: owncloud_backup
    - name: "{{ owncloud.backup_script }} > {{ owncloud.backup_log }} 2>&1"
    - user: root
    {%- if owncloud.backup.cron.special is defined %}
    - special: {{owncloud.backup.cron.special}}
    {%- else %}
      {%- if owncloud.backup.cron.daymonth is defined %}
    - daymonth: {{owncloud.backup.cron.daymonth}}
      {%- endif %}
      {%- if owncloud.backup.cron.month is defined %}
    - month: {{owncloud.backup.cron.month}}
      {%- endif %}
      {%- if owncloud.backup.cron.dayweek is defined %}
    - dayweek: {{owncloud.backup.cron.dayweek}}
      {%- endif %}
      {%- if owncloud.backup.cron.hour is defined %}
    - hour: {{owncloud.backup.cron.hour}}
      {%- endif %}
      {%- if owncloud.backup.cron.minute is defined %}
    - minute: {{owncloud.backup.cron.minute}}
      {%- endif %}
    {%- endif %}
    - require:
      - file: owncloud_backup_script
{%- endif %}
