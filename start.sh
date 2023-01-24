#!/bin/bash

HOST_DIR_NAME=${PWD}

#Include functions
source $(dirname $0)/script/__functions.sh 

msg_warn "Starting vm"
multipass start $VM_NAME

msg_info "$VM_NAME started!"

. $(dirname $0)/script/_hosts_manager.sh

removehost
addhost

echo "------------------------------------------------"
echo ""
msg_warn "Shell on "$VM_NAME
msg_info "multipass shell "$VM_NAME
echo ""

echo "Start VM:"
msg_warn "./start.sh"
echo "Stop VM:"
msg_warn "./stop.sh"
echo "Uninstall VM:"
msg_warn "./uninstall.sh"
echo "------------------------------------------------"
