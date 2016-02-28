#!/usr/bin/env zsh

backupMountDir=${BACKUP_MOUNT_DIR:-/tmp/attic}
backupDir=$backupMountDir/attic-backups
repo=$backupDir/lsd.attic
archive=$(date +%Y-%m-%d_%H:%M:%S)
paths=( ~ )

unmount=

if [[ ! -d $backupDir ]]; then
    ./mountNfs.sh
    unmount=1
fi

./runAttic.sh "$repo" "$archive" "$paths"

if [[ $unmount == "1" ]]; then
    ./umountNfs.sh
fi
