#!/usr/bin/env sh

set -x

if ! command -v swaylock > /dev/null 2>&1
then
    echo "This script need the swaylock to run"
    exit 1
fi

if [ -z "$XDG_DATA_HOME" ]; then
    IMAGE_FOLDER="$HOME/.local/share/swaylock-wrapper/images"
else
    IMAGE_FOLDER="$XDG_DATA_HOME/swaylock-wrapper/images"
fi


(
    flock -n 200 || exit 0
    COLOR=$(shuf -i 0-16777215 -n 1)
    if [ -d $IMAGE_FOLDER ]; then
        IMAGE="-i '$IMAGE_FOLDER/$(ls -1 "$IMAGE_FOLDER" | sort -R  | head -n1)'"
    fi

    swaylock -c "$(printf "%x" $COLOR)" $IMAGE

) 200>/tmp/lockScreen.lock
