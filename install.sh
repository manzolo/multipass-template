#!/bin/bash

HOST_DIR_NAME=${PWD}
#------------------- Env vars ---------------------------------------------
#Number of Cpu for main VM
mainCpu=1
#GB of RAM for main VM
mainRam=1Gb
#GB of HDD for main VM
mainHddGb=10Gb
#--------------------------------------------------------------------------

#Include functions
source $(dirname $0)/script/__functions.sh 

msg_warn "Check prerequisites..."

#Check prerequisites
check_command_exists "multipass"

msg_warn "Creating vm"
multipass launch -m $mainRam -d $mainHddGb -c $mainCpu -n $VM_NAME

msg_info $VM_NAME" is up!"

msg_info "[Task 1]"
msg_warn "Mount host drive with installation scripts"

multipass mount ${HOST_DIR_NAME} $VM_NAME

multipass list

msg_info "[Task 2]"
msg_warn "Installing packages on $VM_NAME"

run_command_on_vm "$VM_NAME" "${HOST_DIR_NAME}/script/_run_docker.sh ${HOST_DIR_NAME}"

msg_info "[Task 3]"
msg_warn "On task complete"

VM_IP=$(multipass info $VM_NAME | grep IPv4 | awk '{print $2}')
msg_warn "Shell on "$VM_NAME
msg_info "multipass shell "$VM_NAME
echo ""
msg_warn "#Run command on "$VM_NAME
command_on_vm="hostname"
command="multipass exec -v ${VM_NAME} -- ${command_on_vm}"
msg_warn "$command"
echo ""
$command
