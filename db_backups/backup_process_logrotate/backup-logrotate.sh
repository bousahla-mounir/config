#!/bin/bash

#### Create the file: sudo nano /usr/local/bin/backup-logrotate.sh

# 1. Force a rotation BEFORE creating the new backup
# This ensures backup.tar.gz is free to be overwritten
logrotate -f /etc/logrotate.d/my-backups

# 2. Create the fresh backup
tar -czf /var/backups/backup.tar.gz /var/www/wordpress
