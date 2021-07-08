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

cat <<EOF > /root/env15.yaml
apiVersion: v1
kind: Pod
metadata:
  name: big-corp-app
spec:
  containers:
  - name: main-container
    image: busybox
    args:
    - /bin/sh
    - -c
    - >
      i=0;
      while true;
      do
        echo "$i: $(date)" >> /var/log/big-corp-app.log;
        i=$((i+1));
        sleep 1;
      done
EOF

kubectl apply -f /root/env15.yaml
