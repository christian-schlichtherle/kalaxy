#CHECK_OPTION = --check

#BASE_OS = raspbian
BASE_OS = ubuntu

#K8S_VARIANT = k3s
K8S_VARIANT = k8s

.PHONY: up down clean

up:
	ansible-playbook $(CHECK_OPTION) $(BASE_OS)-$(K8S_VARIANT)-up.yml

down:
	ansible-playbook $(CHECK_OPTION) $(BASE_OS)-$(K8S_VARIANT)-down.yml

clean:
	rm -f kubeconfig* node-token *.img
