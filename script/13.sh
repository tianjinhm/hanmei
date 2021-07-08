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

apt install -y nfs-kernel-server
rm -rf /nfs
mkdir /nfs
chmod 777 /nfs
cat <<EOF > /etc/exports
/nfs/ *(rw,sync,no_root_squash)  
EOF
systemctl start nfs-kernel-server
systemctl enable nfs-kernel-server
systemctl restart nfs-kernel-server
sed -i "44i\    - --feature-gates=RemoveSelfLink=false" /etc/kubernetes/manifests/kube-apiserver.yaml 
cd ~/hanmei/storageclass
sleep 60
sed -i 's/10.10.10.60/192.168.137.11/g' deployment.yaml
sed -i 's/\/ifs\/kubernetes/\/nfs/g' deployment.yaml
sed -i "4c \  name: csi-hostpath-sc" class.yaml
sed -i "7a \allowVolumeExpansion: true" class.yaml
kubectl apply -f .
