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
rm -rf /root/hanmei >> /dev/null 2>&1
cd /root
git clone https://github.com/tianjinhm/hanmei.git
kubectl create namespace app-team1
