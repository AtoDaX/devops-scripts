#!/usr/bin/env bash
set -euo pipefail

DISK_THRESHOLD=80
PATH_TO_LOG="./monitor.log"

pcent=$(df --output=pcent / | tail -n +2 | tr -d '%')
timestamp=$(date '+%Y-%m-%d %H:%M:%S')

if [[ "$pcent" -gt "$DISK_THRESHOLD" ]]; then
    printf '%s WARNING: root filesystem usage is %s%% (threshold: %s%%)\n' \
        "$timestamp" "$pcent" "$DISK_THRESHOLD" | tee -a "$PATH_TO_LOG" >&2
else
    printf '%s OK: root filesystem usage is %s%%\n' \
        "$timestamp" "$pcent" | tee -a "$PATH_TO_LOG"
fi

printf '/--- Network Audit: %s ---/ \n' "$timestamp" | tee -a "$PATH_TO_LOG"

ss -tulpn | tee -a "$PATH_TO_LOG"