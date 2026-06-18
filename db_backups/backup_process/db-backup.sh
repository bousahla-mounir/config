#!/bin/bash
#### Create the file: sudo nano /usr/local/bin/db-backup.sh
#### sudo chmod +x /usr/local/bin/db-backup.sh

# --- Configuration ---
BACKUP_DIR="/var/backups/mariadb"
DB_NAME="your_dbname"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
RETENTION_DAYS=7

# Ensure backup directory exists
mkdir -p "$BACKUP_DIR"

# 1. Perform the backup (Using modern mariadb-dump)
# We pipe to gzip to save significant disk space
echo "Starting backup of $DB_NAME..."
mariadb-dump --single-transaction --quick "$DB_NAME" | gzip > "$BACKUP_DIR/${DB_NAME}_$TIMESTAMP.sql.gz"

# 2. Check if the backup succeeded
if [ $? -eq 0 ]; then
    echo "Backup successful: ${DB_NAME}_$TIMESTAMP.sql.gz"
else
    echo "Backup FAILED" >&2
    exit 1
fi

# 3. Rotation: Delete backups older than X days
echo "Cleaning up backups older than $RETENTION_DAYS days..."
find "$BACKUP_DIR" -type f -name "*.sql.gz" -mtime +$RETENTION_DAYS -delete

echo "Backup process complete."
