#!/bin/bash

while true; do
    echo "-----" && \
    ./produce && \
    ./consume && \
    ./create_topics && \
    ./list_topics && \
    sleep 3
done
