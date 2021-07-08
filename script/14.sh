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

mkdir /opt/KUTR00101/
cat <<EOF > /root/env14.yaml
kind: Pod
apiVersion: v1
metadata:
  name: bar
spec:
  containers:
    - name: bar
      image: busybox
      args:
            - /bin/sh
            - -c
            - date; echo  Hello from the Kubernetes cluster; date ; echo error unable-to-access-website;sleep 30000
EOF
kubectl apply -f /root/env14.yaml
