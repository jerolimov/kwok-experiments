#!/bin/bash

set -e

# KWOK repository
KWOK_REPO=kubernetes-sigs/kwok

# Get latest
KWOK_LATEST_RELEASE=$(curl -s "https://api.github.com/repos/${KWOK_REPO}/releases/latest" | jq -r '.tag_name')
echo
echo "Detected release ${KWOK_LATEST_RELEASE} on https://github.com/${KWOK_REPO}/releases"
echo
echo "Download kwok-$(go env GOOS)-$(go env GOARCH) as ./kwok ..."
echo
curl -Lo kwok "https://github.com/${KWOK_REPO}/releases/download/${KWOK_LATEST_RELEASE}/kwok-$(go env GOOS)-$(go env GOARCH)"
echo
echo "Download kwokctl-$(go env GOOS)-$(go env GOARCH) as ./kwokctl ..."
echo
curl -Lo kwokctl "https://github.com/${KWOK_REPO}/releases/download/${KWOK_LATEST_RELEASE}/kwokctl-$(go env GOOS)-$(go env GOARCH)"
echo

chmod a+x kwok kwokctl

./kwok --version
./kwokctl --version
