#!/bin/env bash
set -e

trash() {
    local trashdir="${XDG_DATA_HOME:-$HOME/.local/share}/Trash/files"
    mkdir -p "$trashdir"
    mv -- "$@" "$trashdir/"
}

for file in *.zip; do
    full="${file%.*}"
    name="${full#* - }"
    unzip "$file" -d "$name"
    trash "$file"
done

