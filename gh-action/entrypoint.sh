#!/bin/sh

set -e

# Extract the base64 encoded config data and write this to the KUBECONFIG
export PATH="$PATH:/work"

bash -c "$*"
