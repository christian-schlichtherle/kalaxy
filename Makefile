#CHECK_OPTION = --check

#BASE_OS = raspbian
BASE_OS = ubuntu

.PHONY: up k3s-up down k3s-down

up k3s-up: $(BASE_OS)-k3s-up.yml
	ansible-playbook $(CHECK_OPTION) $?

down k3s-down: $(BASE_OS)-k3s-down.yml
	ansible-playbook $(CHECK_OPTION) $?

clean:
	rm -f kubeconfig* node-token *.img
