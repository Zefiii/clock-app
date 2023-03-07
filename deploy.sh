#!/bin/bash

# Error handling 

set -e
set -o pipefail

trap "echo Some error has happend durig the execution on ${BASH_COMMAND}" ERR

# We need to get the ip to substitue it in the ansible inventory
ip="$(virsh domifaddr immfly-debian10 | grep ipv4 | awk '{print $4}' | cut -d/ -f1)"
echo "Welcome to Clock App, immfly-debian10 is running with the ip: $ip"
echo "Updating ip on Ansible inventory"
sed -i "s/=.*/=$ip/" src/ansible/inventory
echo "Building the docker container..."
docker build -t ansible-clock-app:1.0.0 ./src/
echo "Starting the ansible container..."
docker run -it --rm ansible-clock-app:1.0.0
echo "Execution finished, app should be ready on http://$ip"
