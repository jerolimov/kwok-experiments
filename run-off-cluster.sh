#!/bin/bash

kwokctl=kwokctl
if [ -f kwokctl ]; then
    echo "Use ./kwokctl"
    kwokctl=./kwokctl
else
    echo "Use (which kwokctl)"
fi

echo
$kwokctl create cluster --kube-authorization=false
echo
