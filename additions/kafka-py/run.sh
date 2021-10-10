#!/bin/bash

python3 consume.py &

while true; do
    echo "-----" && \
    python3 admin_client.py && \
    python3 produce.py && \
    sleep 5
done
