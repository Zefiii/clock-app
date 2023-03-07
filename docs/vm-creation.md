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
sudo virsh start immfly-debian10
```

We should be able to see it running with the command:

```
❯ sudo virsh list
 Id   Nombre            Estado
------------------------------------
 2    immfly-debian10   ejecutando
```

We are ready to deploy the app. You can find the guide to do it here:

* [App deploy](app-deploy.md)
