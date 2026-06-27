#!/bin/bash

### Create the file: sudo nano /usr/local/bin/backup.sh

# Configuration
SOURCE="/var/www/wordpress"
DEST="/var/backups"
DATE=$(date +%Y-%m-%d)
RETENTION_DAYS=7

# 1. Create the backup (using -z for gzip)
tar -czf "$DEST/backup-$DATE.tar.gz" "$SOURCE"

# 2. The Rotation (The "Senior" part)
# This finds files older than X days and deletes them
find "$DEST" -type f -name "backup-*.tar.gz" -mtime +$RETENTION_DAYS -delete

# 3. Security: Ensure the backup isn't world-readable
chmod 600 "$DEST/backup-$DATE.tar.gz"
