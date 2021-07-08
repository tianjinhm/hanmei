#!/bin/bash
# Copyright 2021 Easthome
#
# SYNOPSIS
#     test1.sh
#
# DESCRIPTION
#     This script is used to grade your Simulation Test
#
# CHANGELOG
#   * Han Mei <108357120@qq.com>
#   - build release

cd /root/hanmei/ingress
sed -i "217c \      hostNetwork: true" mandatory.yaml
kubectl apply -f mandatory.yaml
kubectl create ns ing-internal
kubectl create deployment hi --image=nginx -n ing-internal
kubectl expose deployment hi --name hi --port=5678 --target-port=80 -n ing-internal
