#!/bin/sh
echo -ne '\033c\033]0;Las ratas dan la lata\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/Las ratas dan la lata.x86_64" "$@"
