#!/bin/bash
### Create: nano /usr/local/bin/snap-backup.sh 

VG_NAME="vg_system"
LV_NAME="lv-home"
SNAP_NAME="snap-daily"
SNAP_SIZE="5G"

# 1. Clean up any old crashed snapshots
if lvs $VG_NAME/$SNAP_NAME > /dev/null 2>&1; then
    lvremove -f $VG_NAME/$SNAP_NAME
fi

# 2. Create the snapshot
lvcreate --size $SNAP_SIZE --snapshot --name $SNAP_NAME /dev/$VG_NAME/$LV_NAME

# 3. Use the snapshot (e.g., rsync it to an external disk)
mkdir -p /mnt/snap_mount
mount /dev/$VG_NAME/$SNAP_NAME /mnt/snap_mount
#rsync -a /mnt/snap_mount/ /media/backup_drive/daily_files/
#umount /mnt/snap_mount

# 4. Remove the snapshot (Keep the 'write' performance high)
#lvremove -f $VG_NAME/$SNAP_NAME
