#!/usr/bin/env zsh

backupMountDir=${BACKUP_MOUNT_DIR:-/tmp/attic}
backupHost=172.16.1.5
backupVolume=/volume1/TimeMachine

[[ ! -d $backupMountDir ]] && mkdir $backupMountDir
sudo mount_nfs -P $backupHost:$backupVolume $backupMountDir
