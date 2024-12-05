#!/bin/bash

docker build . -t kubeshark/mizutest-ldap-go:latest && docker push kubeshark/mizutest-ldap-go:latest
