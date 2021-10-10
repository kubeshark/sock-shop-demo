#!/bin/bash

while true; do
    echo "-----" && \
    go run produce.go && \
    go run consume.go && \
    go run create_topics.go && \
    go run list_topics.go
done
