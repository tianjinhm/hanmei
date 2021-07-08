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

cd /root/hanmei
sed -i "88a\          - --kubelet-insecure-tls" /root/hanmei/components.yaml
sed -i "89a\          - --kubelet-preferred-address-types=InternalIP" /root/hanmei/components.yaml
kubectl apply -f /root/hanmei/components.yaml
cat <<EOF > /root/env16.yaml
apiVersion: v1
kind: Pod
metadata:
  name: cpupod
  labels:
    name: cpu-loader
spec:
  containers:
  - name: cpu-demo-ctr
    image: vish/stress
    resources:
      limits:
        cpu: "1"
      requests:
        cpu: "0.5"
    args:
    - -cpus
    - "1"
EOF
kubectl apply -f /root/env16.yaml
