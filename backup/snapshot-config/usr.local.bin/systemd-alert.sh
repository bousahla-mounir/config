#!/bin/bash
### Create: nano /usr/local/bin/systemd-alert.sh 

UNIT_NAME=$1

MESSAGE="CRITICAL: Service $UNIT_NAME failed on $(hostname) at $(date)"

# Send to all logged-in terminals
echo "$MESSAGE" | wall

# Optional: Send an email (requires 'mailutils' or 'ssmtp' installed)
echo "$MESSAGE" | mail -s "Service Failure Alert" adabachir2222@gmail.com
