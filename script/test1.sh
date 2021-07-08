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

SCORE=0
kubectl describe rolebindings -n app-team1 | tr -d "\n"  > exam01.txt
kubectl describe clusterrole deployment-clusterrole | tr -d "\n"  >> exam01.txt
flag010=`cat exam01.txt | grep cicd-tpassen | grep  daemonsets | grep deployments | grep statefulsets | grep create | wc -l`
if [ $flag010 -ne 0 ] ; then
        SCORE=$(expr $SCORE + 4 )
    echo '1 pass'
else
    echo '1 error'
fi
exam020=`kubectl get nodes`
flag020=`echo $exam020 | grep SchedulingDisabled | wc -l`
if [ $flag020 -ne 0 ] ; then
        SCORE=$(expr $SCORE + 4 )
    echo '2 pass'
else
    echo '2 error'
fi
exam030=`kubectl get nodes`
flag030=`echo $exam030 | grep '1.20.1' | wc -l`
if [ $flag030 -ne 0 ] ; then
        SCORE=$(expr $SCORE + 7 )
    echo '3 pass'
else
    echo '3 error'
fi

ETCDCTL_API=3 etcdctl --endpoints https://127.0.0.1:2379 --cert=/opt/KUIN00601/etcd-client.crt --key=/opt/KUIN00601/etcd-client.key --cacert=/opt/KUIN00601/ca.crt endpoint health 2> exam4.txt
flag040=`cat exam4.txt | grep healthy | wc -l`
if [ $flag040 -ne 0 ] && [ -e /data/backup/etcd-snapshot.db ]; then 
	SCORE=$(expr $SCORE + 7 ) 
    echo '4 pass'
else
    echo '4 error'
fi

exam050=`kubectl describe networkpolicies -n internal | tr -d "\n"`
flag050=`echo $exam050 | grep '8080/TCP' | grep "NamespaceSelector: project=internal" | wc -l`
if [ $flag050 -ne 0 ] ; then
        SCORE=$(expr $SCORE + 7 )
    echo '5 pass'
else
    echo '5 error'
fi

exam060=`kubectl get svc`
flag060=`echo $exam060 | grep NodePort | grep 80 | grep front-end-svc | wc -l`
if [ $flag060 -ne 0 ] ; then
        SCORE=$(expr $SCORE + 7 )
    echo '6 pass'
else
    echo '6 error'
fi

curl -skL 192.168.0.11/hi > exam7.txt
curl -skL 192.168.0.12/hi >> exam7.txt
flag070=`cat exam7.txt | grep 'nginx' | wc -l`
if [ $flag070 -ne 0 ] ; then
        SCORE=$(expr $SCORE + 7 )
    echo '7 pass'
else
    echo '7 error'
fi

exam080=`kubectl get deployments presentation`
flag080=`echo $exam080 | grep '3/3' | wc -l`
if [ $flag080 -ne 0 ] ; then
        SCORE=$(expr $SCORE + 4 )
    echo '8 pass'
else
    echo '8 error'
fi

exam090=`kubectl get node -o wide --show-labels | grep disk=spinning | awk '{print $1}'`
flag090=`kubectl get pods nginx-kusc00401 -o wide | grep $exam090 | wc -l`
if [ $flag090 -ne 0 ] ; then
        SCORE=$(expr $SCORE + 4 )
    echo '9 pass'
else
    echo '9 error'
fi

flag100=`cat /opt/KUSC00402/kusc00402.txt | grep 2 | wc -l`
if [ $flag100 -ne 0 ] ; then
        SCORE=$(expr $SCORE + 4 )
    echo '10 pass'
else
    echo '10 error'
fi

exam110=`kubectl get pods kucc8`
flag110=`echo $exam110 | grep '4/4' | grep Running | wc -l`
if [ $flag110 -ne 0 ] ; then
        SCORE=$(expr $SCORE + 4 )
    echo '11 pass'
else
    echo '11 error'
fi

exam120=`kubectl get pv app-config`
flag120=`echo $exam120 | grep ROX | grep 1Gi | wc -l`
if [ $flag120 -ne 0 ] ; then
        SCORE=$(expr $SCORE + 4 )
    echo '12 pass'
else
    echo '12 error'
fi

`kubectl describe pod web-server | tr -d "\n"  > exam13.txt`
flag130=`cat exam13.txt | grep 'Running' | grep pv-volume | wc -l`
if [ $flag130 -ne 0 ] ; then
        SCORE=$(expr $SCORE + 7 )
    echo '13 pass'
else
    echo '13 error'
fi

flag140=`cat /opt/KUTR00101/bar | grep  unable-to-access-website | wc -l`
if [ $flag140 -ne 0 ] ; then
        SCORE=$(expr $SCORE + 5 )
    echo '14 pass'
else
    echo '14 error'
fi

kubectl get pod big-corp-app | tr -d "\n"  > exam15.txt
kubectl describe pod big-corp-app | tr -d "\n"  >> exam15.txt
flag150=`cat exam15.txt | grep 'Running' | grep '2/2' | grep '/var/log/big-corp-app.log' | wc -l`
if [ $flag150 -ne 0 ] ; then
        SCORE=$(expr $SCORE + 7 )
    echo '15 pass'
else
    echo '15 error'
fi

if [ -e /opt/KUTR00401/KUTR00401.txt ] ; then
        SCORE=$(expr $SCORE + 5 )
    echo '16 pass'
else
    echo '16 error'
fi

flag170=`kubectl get nodes k8s-node1 | grep -i notready | wc -l`
if [ $flag170 -ne 0 ] ; then
    echo '17 error'
else
    SCORE=$(expr $SCORE + 13 )
    echo '17 pass'
fi


echo "成绩:"$SCORE

