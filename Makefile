#CHECK_OPTION = --check

#BASE_OS = raspbian
BASE_OS = ubuntu

K8S_VARIANT = k3s

.PHONY: up down clean

up:
	ansible-playbook $(CHECK_OPTION) $(K8S_VARIANT)-$(BASE_OS)-up.yml

down:
	ansible-playbook $(CHECK_OPTION) $(K8S_VARIANT)-$(BASE_OS)-down.yml

clean:
	rm -f kubeconfig* node-token *.img
