#!/bin/bash


echo "SSH agent configuration"
eval `ssh-agent`
ssh-add /home/ansible/rsa
cd /opt/ansible
export PATH=$PATH:/home/ansible/.local/bin
echo "Installing docker collection"
ansible-galaxy collection install community.docker
echo "Running playbook with ansible-playbook -i inventory 00-install-web-servers.yml --diff"
ansible-playbook -i inventory 00-install-web-servers.yml --diff
