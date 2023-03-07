#!/bin/bash

mkdir /image
wget https://immfly-infra-technical-test.s3-eu-west-1.amazonaws.com/debian10-ssh.img.tar.xz
tar -xf debian10-ssh.img.tar.xz -C /image
chown -R libvirt-qemu /image

