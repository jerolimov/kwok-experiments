#!/bin/bash

set -e

echo
echo "Use kubectl to extract server configuration..."
echo

#kubectl config view -o json | jq '.["current-context"]'

current_context=$(kubectl config view -o json | jq -r '.["current-context"]')
echo "Current context: $current_context"

#echo
#kubectl config view -o json | jq -r ".contexts[] | select(.name == \"$current_context\")"

cluster_ref=$(kubectl config view -o json | jq -r ".contexts[] | select(.name == \"$current_context\").context.cluster")
#echo "  Cluster ref: $cluster_ref"

user_ref=$(kubectl config view -o json | jq -r ".contexts[] | select(.name == \"$current_context\").context.user")
#echo "  User ref: $user_ref"

#echo
#kubectl config view -o json | jq ".clusters[] | select(.name == \"$cluster_ref\")"

server=$(kubectl config view -o json | jq -r ".clusters[] | select(.name == \"$cluster_ref\").cluster.server")
echo "  Server:     $server"

server_ca=$(kubectl config view -o json | jq -r ".clusters[] | select(.name == \"$cluster_ref\").cluster[\"certificate-authority\"]")
echo "  Server CA:  $server_ca"

#echo
#kubectl config view -o json | jq ".users[] | select(.name == \"$user_ref\")"

client_ca=$(kubectl config view -o json | jq -r ".users[] | select(.name == \"$user_ref\").user[\"client-certificate\"]")
echo "  Client CA:  $client_ca"

client_key=$(kubectl config view -o json | jq -r ".users[] | select(.name == \"$user_ref\").user[\"client-key\"]")
echo "  Client Key: $client_key"

# Custom base address
export BRIDGE_LISTEN="http://localhost:9091"

# Use test-env k8s api
export BRIDGE_USER_AUTH="disabled"
export BRIDGE_K8S_MODE="off-cluster"
export BRIDGE_K8S_MODE_OFF_CLUSTER_ENDPOINT=$server
export BRIDGE_K8S_MODE_OFF_CLUSTER_SKIP_VERIFY_TLS=true
export BRIDGE_K8S_AUTH="bearer-token"
export BRIDGE_K8S_AUTH_BEARER_TOKEN=""

cd $HOME/git/openshift/console && ./bin/bridge
