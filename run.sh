#!/bin/bash
set -e

CONTAINER_NAME="alpine-chromium-gui"
IMAGE_NAME="alpine-chromium-gui"
PORT="9999"

# Stop and remove existing container if running
if [ "$(docker ps -aq -f name=^/${CONTAINER_NAME}$)" ]; then
    echo "Stopping existing container ${CONTAINER_NAME}..."
    docker stop "${CONTAINER_NAME}" 2>/dev/null || true
    docker rm "${CONTAINER_NAME}" 2>/dev/null || true
fi

echo "Starting ${CONTAINER_NAME} on port ${PORT}..."
docker run -d \
    --name "${CONTAINER_NAME}" \
    -p "${PORT}:8080" \
    -v "$(pwd)/notes.html:/root/notes.html:ro" \
    --shm-size=1g \
    --restart=unless-stopped \
    "${IMAGE_NAME}"

echo ""
echo "=========================================================="
echo " Container is running!"
echo " Access the Chromium Web GUI at: http://localhost:${PORT}"
echo "=========================================================="
