#!/usr/bin/env zsh

backupMountDir=${BACKUP_MOUNT_DIR:-/tmp/attic}

sudo umount $backupMountDir
