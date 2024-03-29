#!/bin/bash

echo "Running apt install..."
sudo apt update -y && sudo apt install git ansible sshpass

echo "Install ansible plugins..."
ansible-galaxy collection install ansible.posix
ansible-galaxy install gantsign.golang

echo "Running ansible..."
ansible-playbook --ask-become-pass -i ansible/inventory/local_host ansible/local.yml --extra-vars '{"dotdotdot_path":"~/dotdotdot"}'
