# Kalaxy

This repository contains Ansible playbooks for provisioning a multi-node Kubernetes cluster with Ansible.
It was originally developed to install Kubernetes on an array of Raspberry Pi Model 4B, but has since been refactored to
support any hardware or virtual machine which runs a Debian based Linux distribution, e.g. AWS EC2 instances running Ubuntu
Server.

The Ansible playbooks support:

- multi-node cluster setup
- tear-down of the entire cluster or just individual nodes for re-purposing them
- installation of original Kubernetes (k8s) or k3s
- optional private Docker registry
- optional Docker registry mirror
- optional HTTP(S) proxies

As for the documentation, please refer to my
[blog page](https://illegalexception.schlichtherle.de/kubernetes/2019/09/12/provisioning-a-kubernetes-cluster-on-raspberry-pi-with-ansible/)
about this project.
