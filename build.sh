#!/bin/bash -eu

chown -R $(id -u):$(id -g) .
aws cloudformation validate-template --template-body  file://template.yaml 1>/dev/null &&
sam validate &&
sam build
