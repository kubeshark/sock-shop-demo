#!/bin/bash

docker build . -t kubehq/mizutest-amqp-py:latest && docker push kubehq/mizutest-amqp-py:latest