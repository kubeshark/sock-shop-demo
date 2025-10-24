#!/bin/bash

docker build . -t kubehq/mizutest-redis-go:latest && docker push kubehq/mizutest-redis-go:latest
