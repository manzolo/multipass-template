#!/bin/bash

HOST_DIR_NAME=${PWD}
#------------------- Env vars ---------------------------------------------
#Number of Cpu for main VM
mainCpu=1
#GB of RAM for main VM
mainRam=1Gb
#GB of HDD for main VM
mainHddGb=5Gb
#--------------------------------------------------------------------------

#Include functions
. $(dirname $0)/script/__functions.sh 

msg_warn "Check prerequisites..."

#Check prerequisites
check_command_exists "multipass"

msg_warn "Creating vm"
multipass launch -m $mainRam -d $mainHddGb -c $mainCpu -n $VM_NAME

msg_info $VM_NAME" is up!"

msg_info "[Task 1]"
msg_warn "Mount host drive with installation scripts"

multipass mount ${HOST_DIR_NAME} $VM_NAME

#multipass list

msg_info "[Task 2]"
msg_warn "Configure $VM_NAME"

run_command_on_vm "$VM_NAME" "${HOST_DIR_NAME}/script/_configure.sh ${HOST_DIR_NAME}"

sleep ${SLEEP_BEFORE_START:-10}
multipass list
${HOST_DIR_NAME}/stop.sh
multipass list
${HOST_DIR_NAME}/start.sh

multipass umount "$VM_NAME:${HOST_DIR_NAME}"
multipass mount ${HOST_DIR_NAME} $VM_NAME
run_command_on_vm "$VM_NAME" "${HOST_DIR_NAME}/script/_complete.sh ${HOST_DIR_NAME}"
multipass umount "$VM_NAME:${HOST_DIR_NAME}"
${HOST_DIR_NAME}/stop.sh

msg_info "[Task 2]"
msg_warn "Start $VM_NAME"
${HOST_DIR_NAME}/start.sh

msg_info "[Task 3]"
msg_warn "On task complete"

