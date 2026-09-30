#!/bin/bash
# Sync text into the Docker container clipboard
# Usage:
#   ./clip.sh "your text here"
#   pbpaste | ./clip.sh

CONTAINER_NAME="alpine-chromium-gui"

if [ -t 0 ]; then
    # Input passed as arguments
    TEXT="$*"
else
    # Input piped from stdin (e.g. pbpaste | ./clip.sh)
    TEXT="$(cat)"
fi

if [ -z "$TEXT" ]; then
    echo "Usage: ./clip.sh \"text to copy\" or pbpaste | ./clip.sh"
    exit 1
fi

docker exec -i -e DISPLAY=:1 "${CONTAINER_NAME}" sh -c '
    cat > /tmp/.clip_tmp
    xclip -selection clipboard -i /tmp/.clip_tmp
    xclip -selection primary -i /tmp/.clip_tmp
    rm -f /tmp/.clip_tmp
' <<< "$TEXT"

echo "Copied to container clipboard successfully!"
