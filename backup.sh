#!/bin/bash

# Backup script for the discourse forum
# Don't forget to set FTP_PWD before calling the script

set +e

cd /var/www/soudesecoles/
tar cvzf backups/sou_$(date +%d-%b-%Y_%H:%m:%S).tar.gz /var/lib/docker/volumes/soudesecoles_*

find /var/www/soudesecoles/backups/ -type f -ctime +30 -exec rm {} \;

lftp <<EOF
set sftp:auto-confirm true
open -u sd-118654,${FTP_PWD} ftp://dedibackup-dc3.online.net
ls sou_backups
mirror -v -e -R /var/www/soudesecoles/backups sou_backups
EOF
