#!/bin/bash

set -e

version=v0.11.0

kubectl create -f https://raw.githubusercontent.com/shipwright-io/build/$version/deploy/crds/shipwright.io_buildruns.yaml
kubectl create -f https://raw.githubusercontent.com/shipwright-io/build/$version/deploy/crds/shipwright.io_builds.yaml   
kubectl create -f https://raw.githubusercontent.com/shipwright-io/build/$version/deploy/crds/shipwright.io_buildstrategies.yaml
kubectl create -f https://raw.githubusercontent.com/shipwright-io/build/$version/deploy/crds/shipwright.io_clusterbuildstrategies.yaml
