#!/bin/bash

set -e

# KWOK repository
KWOK_REPO=kubernetes-sigs/kwok

# Get latest
KWOK_LATEST_RELEASE=$(curl "https://api.github.com/repos/${KWOK_REPO}/releases/latest" | jq -r '.tag_name')
echo
echo "Detected release ${KWOK_LATEST_RELEASE} on https://github.com/${KWOK_REPO}/releases"
echo
echo "Download kwok and kwokctl via go install sigs.k8s.io/kwok/cmd/{kwok,kwokctl}@${KWOK_LATEST_RELEASE}"
echo

go install sigs.k8s.io/kwok/cmd/{kwok,kwokctl}@${KWOK_LATEST_RELEASE}
