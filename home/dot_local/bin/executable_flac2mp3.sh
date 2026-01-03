#!/usr/bin/env bash

set -euo pipefail

REMOVE_LIST="flac_to_remove.txt"
: > "$REMOVE_LIST"

current_dst=""

cleanup() {
    if [[ -n "${current_dst:-}" && -f "$current_dst" ]]; then
        echo
        echo "INTERRUPTED: removing incomplete file $current_dst"
        rm -f "$current_dst"
    fi
    exit 130
}

trap cleanup INT TERM

find . -type f -iname '*.flac' -print0 |
while IFS= read -r -d '' src; do
    dst="${src%.flac}.mp3"

    # Reset current target
    current_dst=""

    # 1. Skip if destination exists
    if [[ -f "$dst" ]]; then
        echo "SKIP: $dst already exists"
        continue
    fi

    echo "ENCODE: $src → $dst"

    current_dst="$dst"

    if ffmpeg -nostdin -loglevel error -stats \
        -i "$src" \
        -map_metadata 0 \
        -map 0:a \
        -map 0:v? \
        -c:a libmp3lame -q:a 0 \
        -c:v copy \
        "$dst"
    then
        # Encoding finished successfully
        printf '%s\n' "$src" >> "$REMOVE_LIST"
        current_dst=""
    else
        echo "ERROR: failed to convert $src" >&2
        rm -f "$dst"
        current_dst=""
    fi
done
