#!/bin/bash


eval `ssh-agent`
ssh-add /home/ansible/rsa
echo "Tot ok de moment"
cd /opt/ansible
export PATH=$PATH:/home/ansible/.local/bin
ansible-galaxy collection install community.docker
ansible-playbook -i inventory 00-install-web-servers.yml --diff
