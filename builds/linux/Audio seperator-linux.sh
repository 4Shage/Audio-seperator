#!/bin/sh
echo -ne '\033c\033]0;Audio seperator\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/Audio seperator-linux.x86_64" "$@"
