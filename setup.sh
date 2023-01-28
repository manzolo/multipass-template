#!/bin/bash

HOST_DIR_NAME=${PWD}
#------------------- Env vars ---------------------------------------------
#Number of Cpu for main VM
mainCpu=1
#GB of RAM for main VM
mainRam=1Gb
#GB of HDD for main VM
mainHddGb=5Gb
VM_INSTALL_PATH=/home/ubuntu/setup
#--------------------------------------------------------------------------

#Include functions
. $(dirname $0)/script/__functions.sh 

msg_warn "Check prerequisites..."

#Check prerequisites
check_command_exists "multipass"

msg_warn "Creating vm"
multipass launch -m $mainRam -d $mainHddGb -c $mainCpu -n $VM_NAME lts

msg_info $VM_NAME" is up!"

msg_info "[Task 1]"
msg_warn "Mount host drive with installation scripts"
multipass transfer --recursive ${HOST_DIR_NAME} $VM_NAME:$VM_INSTALL_PATH

#multipass list

msg_info "[Task 2]"
msg_warn "Configure $VM_NAME"

run_command_on_vm "$VM_NAME" "$VM_INSTALL_PATH/script/_configure.sh ${VM_INSTALL_PATH}"
run_command_on_vm "$VM_NAME" "sudo shutdown -h now"

sleep 10

${HOST_DIR_NAME}/start.sh -v

run_command_on_vm "$VM_NAME" "${VM_INSTALL_PATH}/script/_complete.sh ${VM_INSTALL_PATH}"

msg_info "[Task 2]"
msg_warn "Start $VM_NAME"
${HOST_DIR_NAME}/start.sh

msg_info "[Task 3]"
msg_warn "On task complete"

