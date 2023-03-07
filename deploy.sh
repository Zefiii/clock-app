#!/bin/bash

#We need to get the ip to substitue it in the ansible inventory
ip="$(virsh domifaddr immfly-debian10 | grep ipv4 | awk '{print $4}' | cut -d/ -f1)"

