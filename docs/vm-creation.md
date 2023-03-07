# VM Creation

Before starting, if we do not have libvirt installed in our system we will need
to install it. Below you can find instructions to install it in Manjaro Linux.

## Installing libvirt (Majaro instructions)
We are going to need to install the packages, to do so you will need sudo permission
and you will have to run:

```
sudo pacman -S qemu virt-manager virt-viewer dnsmasq vde2 bridge-utils openbsd-netcat
```

Once installed, we are going to start the service with:

```
sudo systemctl start libvirtd
```

Let's start the default network so we can import the vm:

```
sudo virsh net-define /etc/libvirt/qemu/networks/default.xml
sudo virsh net-autostart default
sudo virsh net-start default
```

We are ready to keep going with the rest of the documentation.
 
## Setting up permissions and importing the VM
First of all, we are going to download and extract the VM disk so we can start
creating the machine. To do so we are going to access to the root of this
repository and execute the following commands:

```
sudo mkdir /vms
wget https://immfly-infra-technical-test.s3-eu-west-1.amazonaws.com/debian10-ssh.img.tar.xz
sudo tar -xf debian10-ssh.img.tar.xz -C /vms
rm debian10-ssh.img.tar.xz
```

We are going to change the owner of the debian image and the directory where we have
extracted it. In my case I have used: 

```
sudo chown -R libvirt-qemu /vms
```

Now, we access the cloned repository and we edit the file assests/vm.xml, we have to
edit the line:

```
<source file='${PATH_TO_VM_DISK_FILE}'/>
```

And we let it as:

```
<source file='/vms/debian10-ssh.img'/>
```

We are ready to import the image with:

```
sudo virsh define assets/vm.xml
```

We should be able to see it running with the command:

```
❯ sudo virsh list
 Id   Nombre            Estado
------------------------------------
 2    immfly-debian10   ejecutando
```

And we can get the ip to connect to the vm with:

```
❯ sudo virsh net-dhcp-leases default
 Expiry Time           dirección MAC       Protocol   IP address           Hostname   Client ID or DUID
------------------------------------------------------------------------------------------------------------------------------------------------
 2023-03-03 18:09:55   52:54:00:c0:e9:b1   ipv4       192.168.122.188/24   debian     ff:00:c0:e9:b1:00:01:00:01:26:56:9c:47:52:54:00:a3:08:2e

```

## Connecting to the VM

If all the previous steps have worked as expected we should be ready to ssh into
the machine. We need to change the permissions of the RSA key, as it has too 
open permissions to work. We are going to execute:

```
sudo chown 640 assets/rsa
```

We are now 100% ready to access the machine with the command:

```
ssh -i assets/rsa root@<ip-you-got-from-the-virsh-command>
```

To keep going, please, start reading the application-deploy.md file.

