# Kalaxy

This repository contains Ansible playbooks for provisioning a multi-node Kubernetes cluster with Ansible. It was
originally developed to install Kubernetes on an array of Raspberry Pi Model 4B, but has since been extended to support
any hardware or virtual machine which runs a Debian based Linux distribution, e.g. AWS EC2 instances running Ubuntu
Server.

<p align="center">
<a href="https://illegalexception.schlichtherle.de/assets/2019/09/raspi-array-1920x3406.jpg">
<img src="https://illegalexception.schlichtherle.de/assets/2019/09/raspi-array-0320x0568.jpg" alt="An array of Raspberry Pi Model 4B">
</a>
</p>

The Ansible playbooks support:

- multi-node cluster setup
- multi-master setup
- installation of K3s, a Rancher distribution of Kubernetes
- tear-down of the entire cluster or just individual nodes for re-purposing them
- external container registry mirror (optional)
- external HTTP(S) proxies for apt and others (optional)
- adding taints and labels to nodes (optional)
- selecting network interfaces for nodes (optional)
- configuring CNI plugins (optional)

For more information, please refer to my
[blog posting](https://illegalexception.schlichtherle.de/kubernetes/2019/09/12/provisioning-a-kubernetes-cluster-on-raspberry-pi-with-ansible/)
about this project.
