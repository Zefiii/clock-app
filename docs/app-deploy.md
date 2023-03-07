# App Deploy

To deploy the app we have a single script that does all the work for us once
we have the VM running and all the requirements acomplished.To execute it we
just need to ensure that it has execution permissions and run it. The script
is called deploy.sh and it is in charge of getting the ip of the VM, ensure
that the ip of the ansible inventory is the one of the VM, build the Ansible
image and run the container that is going to run the playbook. You can see
the code below:


```
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
```

As you can see in the code it gives us information about how is it going and
it also tells you where to find the web once it finishes.


To execute it, in the root of the directory we are going to execute:

```
chmod +x deploy.sh # To ensure that we have execution permissions
sudo ./deploy.sh # Sudo to ensure that we can interact with virsh without problems
```

Once it finishes everything is running.
