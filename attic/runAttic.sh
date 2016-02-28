#!/usr/bin/env zsh

resumeLastAtticFile="resumeLastAtticBackup-$(date +%s).sh"

if [[ $# -lt 3 ]]; then
    echo "Usage: $0 <archive> <backup> <paths>" >&2
    exit 1
fi

repo="$1"
shift
archive="$1"
shift
paths="$@"

errExit () {
    echo "Execute $resumeLastAtticFile to resume backup." >&2
    echo "Optionally, delete checkpoint archive manually by running:" >&2
    echo "  attic delete -v --stats ${repo}::${archive}.checkpoint" >&2
}
trap errExit EXIT

if [[ ! -e $repo ]]; then
    echo "Archive $repo doesn't exist. Initializing new archive." >&2
    attic init "$repo"
fi

echo "Existing backups in archive $repo: " >&2
attic list "$repo"

echo<<EOT >! "$resumeLastAtticFile"
#!/usr/bin/env zsh

"$0" "$repo" "$archive" "$paths"
EOT
chmod +x "$resumeLastAtticFile"

attic create \
    --verbose \
    --stats \
    --exclude-from atticExcludeFile \
    --exclude-caches \
    "${repo}::${archive}" "$paths"

rm "$resumeLastAtticFile"
