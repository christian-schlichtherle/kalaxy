# Provisioning Kubernetes (K8s) on Raspberry Pi's with Ansible

With this repository you can easily set-up and tear-down a multi-node Kubernetes cluster on an array of 
Raspberry Pi's in a couple of minutes.
I use this repository to run K8s on an array of Raspberry Pi 4's with 4 GB memory (see below).

The Ansible playbooks in this repository provision [k3s](https://k3s.io) or the original Kubernetes (subsequently called 
k8s) on Raspbian Buster, 32 bit (armhf), or Ubuntu 18.04.3 LTS (Bionic Beaver), 64 bit (aarch64).
Other Kubernetes variants, OS images or versions may work, but haven't been tested.
As of September 4th, the following constraints apply:

- Only one master

![An array of Raspberry Pi 4's](docs/images/raspi-array.jpg)

```shell script
$ make
[...]
$ kubectl --kubeconfig build/k3s-config.yml get nodes -o wide
NAME     STATUS   ROLES    AGE   VERSION         INTERNAL-IP     EXTERNAL-IP   OS-IMAGE             KERNEL-VERSION   CONTAINER-RUNTIME
node3    Ready    worker   39m   v1.15.3-k3s.1   192.168.71.23   <none>        Ubuntu 18.04.3 LTS   4.19.69-v8+      docker://18.9.9
node1    Ready    master   39m   v1.15.3-k3s.1   192.168.71.21   <none>        Ubuntu 18.04.3 LTS   4.19.69-v8+      docker://18.9.9
node2    Ready    worker   38m   v1.15.3-k3s.1   192.168.71.22   <none>        Ubuntu 18.04.3 LTS   4.19.69-v8+      docker://18.9.9
$ kubectl --kubeconfig build/k8s-config.yml get nodes -o wide
NAME     STATUS   ROLES    AGE   VERSION   INTERNAL-IP     EXTERNAL-IP   OS-IMAGE             KERNEL-VERSION   CONTAINER-RUNTIME
node4    Ready    master   36m   v1.15.3   192.168.71.24   <none>        Ubuntu 18.04.3 LTS   4.19.69-v8+      docker://18.9.9
node5    Ready    <none>   15m   v1.15.3   192.168.71.25   <none>        Ubuntu 18.04.3 LTS   4.19.69-v8+      docker://18.9.9
node6    Ready    <none>   15m   v1.15.3   192.168.71.26   <none>        Ubuntu 18.04.3 LTS   4.19.69-v8+      docker://18.9.9
$ kubectl --kubeconfig build/k3s-config.yml run -it --restart=Never --image=openjdk:11-jdk doesntmatter
If you don't see a command prompt, try pressing enter.
Sep 01, 2019 7:34:03 PM java.util.prefs.FileSystemPreferences$1 run
INFO: Created user preferences directory.
|  Welcome to JShell -- Version 11.0.4
|  For an introduction type: /help intro

jshell> /exit
|  Goodbye
$ kubectl --kubeconfig build/k8s-config.yml run -it --restart=Never --image=openjdk:11-jdk doesntmatter
[...]
$ ansible all -a 'free -m'
node6 | CHANGED | rc=0 >>
              total        used        free      shared  buff/cache   available
Mem:           3856         352         833           2        2671        3455
Swap:             0           0           0

node1 | CHANGED | rc=0 >>
              total        used        free      shared  buff/cache   available
Mem:           3856         642        1893           3        1320        3177
Swap:             0           0           0

node2 | CHANGED | rc=0 >>
              total        used        free      shared  buff/cache   available
Mem:           3856         330        1906           2        1620        3476
Swap:             0           0           0

node5 | CHANGED | rc=0 >>
              total        used        free      shared  buff/cache   available
Mem:           3856         330        1538           2        1987        3476
Swap:             0           0           0

node3 | CHANGED | rc=0 >>
              total        used        free      shared  buff/cache   available
Mem:           3856         309        2488           2        1058        3497
Swap:             0           0           0

node4 | CHANGED | rc=0 >>
              total        used        free      shared  buff/cache   available
Mem:           3856         684        1217           3        1954        3153
Swap:             0           0           0

```

## Prerequisites

### Hardware

You need an array of Raspberry Pi's. 
The number of Pi's can be as small as one, for one master node, but should be at least two, for one master node and one
worker node - the more the better of course.

As you can see from the shell transcript above, as little as 1 GB memory should be enough, but you will probably not be
able to run any interesting apps then, so for best results, get some Raspberry Pi 4's with 4 GB memory.

Also, for best performance, the Pi's should be connected via Ethernet cable, not WiFi.
There is a caveat with Raspberry Pi 3+ and older, however:
The Ethernet port is connected to the USB 2.0 controller, which effectively limits the available bandwidth to about
224 Mbps.
The Raspberry Pi 4 can sustain over 900 Mbps with adequate cooling.
For my setup I have chosen the Power-over-Ethernet (PoE) HATs, which have a built-in fan.   

Next, all the performance is waisted if you go for a cheap switch:
The problem with cheap switches is that their backplanes often don't provide enough bandwidth for full-duplex 
transmission on all ports in parallel - this is the same problem as with the Ethernet port on older Raspberry Pi's.  
For best results, you need a switch with at least N + 1 ports (for N Pis' plus an uplink to your router) and a backplane 
bandwidth of at least 2 * (N + 1) Gbps.
For my setup I have chosen an unmanaged switch with 8 PoE ports from Trendmicro.
It's backplane has a bandwidth capacity of 16 Gbps.
The two additional ports I connect to my router and Network-Attached-Storage (NAS).
PoE is really neat for a use case like this:
The extra money I've spent on the switch I've probably saved on power supplies for the Pi's - I don't need any!      

Last, but not least, all the performance is waisted again unless you also go for some high performance microSDXC card.
I have chosen SanDisk Extreme PRO 64 GB µSDXC A2.
For big data apps, I will use the S3 compatible service of my NAS, though.

![SanDisk Extreme PRO 64 GB µSDXC A2](docs/images/micro-sdxc.jpg)

### Software

I'm using Ansible 2.8.4 with Python 3.7.3 on macOS. Other versions may work, but haven't been tested.

[To be continued... disk images ... flashing software ... kubectl]

## Configuration

You need to edit the `inventory.yml` file to match the IP address of each Pi in your array and the desired Kubernetes
variant, i.e. k3s or k8s, by adding or removing your hosts to the respective groups.
In case you want to install k3s, you also need to configure the desired 
[k3s release](https://github.com/rancher/k3s/releases).
By default, the latest k3s release gets installed.

Run `ansible all -m ping` to verify your inventory.
For my setup, it shows:

```shell script
$ ansible all -m ping
node1 | SUCCESS => {
    "changed": false,
    "ping": "pong"
}
node4 | SUCCESS => {
    "changed": false,
    "ping": "pong"
}
node3 | SUCCESS => {
    "changed": false,
    "ping": "pong"
}
node5 | SUCCESS => {
    "changed": false,
    "ping": "pong"
}
node2 | SUCCESS => {
    "changed": false,
    "ping": "pong"
}
node6 | SUCCESS => {
    "changed": false,
    "ping": "pong"
}
```

You also need to edit the `Makefile` to match the base OS. 
By default, the base OS is assumed to be Ubuntu.

## Provisioning

You can now set up the cluster:

```shell script
$ make up
[...]
```

To configure kubectl to talk to your cluster:

```shell script
$ export KUBECONFIG="$PWD/k?s-config.yml"
```

To verify everything is working as expected:

```shell script
$ kubectl get nodes -o wide
[...]
$ ansible all -a 'free -m'
[...]
```

To tear down the cluster:

```shell script
$ make down
[...]
```

That's it - enjoy!
