#!/bin/bash

cd grpc/examples/python/route_guide/
python3 route_guide_server.py &

while true
do
    python3 route_guide_client.py && \
    sleep 3
done
