#!/bin/sh

# Ensure that the script fails on errors
set -e

# Default values for variables
COMPRESSED=${COMPRESSED:-false}
SERVER_URL=${SERVER_URL:-"ws://websocket-server-service.sock-shop.svc.cluster.local:80"}

# Log the start of the client
echo "Starting WebSocket client..."
echo "Connecting to server: $SERVER_URL"
echo "Compression enabled: $COMPRESSED"

# Run the WebSocket client with the provided options
python example.py --server "$SERVER_URL" --compressed "$COMPRESSED"
