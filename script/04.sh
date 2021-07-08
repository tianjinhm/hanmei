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

cid=`docker ps | grep etcd_etcd | awk '{print $1}'`
docker cp $cid:/usr/local/bin/etcdctl /usr/bin
mkdir -p /data/backup
mkdir -p /opt/KUIN00601
cp /etc/kubernetes/pki/etcd/ca.crt /opt/KUIN00601/ca.crt
cp /etc/kubernetes/pki/etcd/peer.crt /opt/KUIN00601/etcd-client.crt
cp /etc/kubernetes/pki/etcd/peer.key /opt/KUIN00601/etcd-client.key
mkdir -p /srv/data
ETCDCTL_API=3 etcdctl --endpoints https://127.0.0.1:2379  --cert=/opt/KUIN00601/etcd-client.crt --key=/opt/KUIN00601/etcd-client.key --cacert=/etc/kubernetes/pki/etcd/ca.crt snapshot save /srv/data/etcd-snapshot-previous.db >> /dev/null 2>&1
