# VOLTHA Scale Testing
This project contains several [Packer](https://www.packer.io/intro/index.html) scripts
that can be used to generate [VOLTHA](https://wiki.opencord.org/display/CORD/VOLTHA)
and [SEBA](https://wiki.opencord.org/display/CORD/SEBA) qcow2 images for scale testing.
In addition, these Packer scripts may also be useful for setting up VOLTHA instances
for other purposes as well.


**NOTE**: Until some initial v1.x VOLTHA testing is performed, the v2.0 and SEBA packer
          scripts probably will not be debugged/functional/...

## Prerequisites
- _Ubuntu 16.04_ system with free disk-space to run packer.  Packer can also be ran
  on other operating systems, but these steps have only been tested under Ubuntu.
  
- Install [Packer](https://www.packer.io/intro/index.html)

- A server to run the created qcow's on.  I would suggest devoting at least 4 vCPUs
  and 8GB to the launched images.  SEBA scale testing will probably be more.
  An exact number for both configurations is still TBD, so the requirements may be less.

## Building QCOW3 images
The packer subdirectory contains a number of packer JSON file for building test images.

| File              | username/pwd  | Description |
| ----------------- | :-----------: | :---------- |
| voltha-1.x.json   | voltha/admin  | Creates a qcow image with the latest VOLTHA v1.x containers |
| voltha-2.0.json   | voltha/admin  | Creates a qcow image with the latest VOLTHA v2.0 containers |
| seba-1.0-att.json | seba/admin    | Creates a qcow image with the latest SEBA v1.0 containers (AT&T workflow) |

All images built at this time are for single-image deployment.  Cluster support is a future goal.

To create an image:
```bash
cd packer
packer build **_filename.json_**
```
Building will often 20-30 minutes and will output the QCOW2 results (if successful) in
a subdirectory with the same name as the base filename.  For the VOLTHA images both docker-compose
and kubernetes can be used to run the images with docker-compose as the default.  

Kubernetes requires a static-IP address assignment and work needs to be done to support
auto-generating a k8s instance.

**Note**: The VOLTHA scripts are a month old and may need updating. The SEBA scrips are a work
          in progress.

## Launching an image
Here are some ways to launch and test your created images.

### libvirt
The following will run the VOLTHA 1.x qcow2 file with 8GB of memory and 4 vCPUs. No external network
connections are required while running a stress/scalability test.

**Creating a new VM via CLI**:
```bash
$ virt-install --connect qemu:///system --memory 8000 --vcpus 4 --disk path=output-voltha-1.x/voltha-1.x \
               --name VOLTHA1x --autostart --noautoconsole --import \
               #--network=NETWORK-CONNECTION-1 --network=NETWORK-CONNECTION-2 ...
```

**Validating that the image is running**:
```bash
$ virsh list          # Should see image with the 'name' supplied running with and ID number
 Id    Name                           State
----------------------------------------------------
 1     VOLTHA1x                       running
#
# Exec a shell
$ virsh console VOLTHA1x
Connected to domain VOLTHA1x
Escape character is ^]

Ubuntu 16.04.5 LTS voltha-1 ttyS0

voltha-1 login: voltha
Password: 
Welcome to Ubuntu 16.04.5 LTS (GNU/Linux 4.4.0-131-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage
New release '18.04.1 LTS' available.
Run 'do-release-upgrade' to upgrade to it.

voltha@voltha-1:~$ 

```
**Cleanup when you are done**:
```bash
$ virsh shutdown VOLTHA1x
Domain VOLTHA1x is being shutdown

virsh list
 Id    Name                           State
----------------------------------------------------

$ virsh undefine VOLTHA1x
```

## Items To Be Done
These items need to be performed and images/readmes updated accordingly.
  
- Determine how best to support creation of a k8s single-node installation. This may
  need to generate most of the kubernetes install the first time the unit is ran and
  then a warning message about IP address assignment may be needed.
  
- Determine how to update the k8s certificates so that the dynamic IP Address assignment
  at KVM startup instance can be supported.

- Test VOLTHA v1.x and v2.0 with various vCPU and memory settings and provide a graph
  of the results to help locate a minimal setting.
  
- Test SEBA v1.0 with various vCPU and memory settings and provide a graph
  of the results to help locate a minimal setting.