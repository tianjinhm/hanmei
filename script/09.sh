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

kubectl label node k8s-node1 disk=spinning
