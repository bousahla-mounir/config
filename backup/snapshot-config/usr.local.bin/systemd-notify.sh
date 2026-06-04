#!/bin/bash
STATUS=$1   # SUCCESS or FAIL
UNIT=$2     # Service Name

LOGFILE="/var/log/snapshot/backup-status.log"
MESSAGE="[$STATUS] Service $UNIT finished at $(date)"

# 1. Append to your custom log file
echo "$MESSAGE" >> "$LOGFILE"

# 2. Send email via Postfix (if configured)
# The -s is the subject, followed by the recipient email
echo "$MESSAGE" | mail -s "Backup $STATUS: $UNIT" adabachir2222@gmail.com
