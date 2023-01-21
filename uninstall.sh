#!/bin/bash

#Include functions
source $(dirname $0)/script/__functions.sh

msg_warn "== Clean vm"

echo "remove k8s-main"
multipass delete $VM_NAME
multipass purge
multipass list

rm -rf "./script/_test.sh"
rm -rf "./config/hosts"

msg_info "== Vm clear"
