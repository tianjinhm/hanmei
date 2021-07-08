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

kubectl create namespace internal
kubectl run -n internal busybox --image=busybox:1.28.3 sleep 3600000
kubectl run -n internal http1 --image=httpd
sleep 60
kubectl -n internal exec -it http1 -- sed -i "52c listen 8080" /usr/local/apache2/conf/httpd.conf
kubectl -n internal exec -it http1 -- sed -i "241c ServerName localhost:8080" /usr/local/apache2/conf/httpd.conf
kubectl -n internal exec -it http1 -- httpd -k restart

kubectl expose pod -n internal http1 --port=8080 
kubectl label ns internal project=internal
