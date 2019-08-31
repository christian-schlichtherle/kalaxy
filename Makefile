#CHECK_OPTION = --check

#BASE_OS = raspbian
BASE_OS = ubuntu

.PHONY: up k3s-up raspbian-k3s-up ubuntu-k3s-up down k3s-down raspbian-k3s-down ubuntu-k3s-down

up k3s-up: $(BASE_OS)-k3s-up

down k3s-down: $(BASE_OS)-k3s-down

raspbian-k3s-up:
	ansible-playbook $(CHECK_OPTION) raspbian-k3s-up.yml

raspbian-k3s-down:
	ansible-playbook $(CHECK_OPTION) raspbian-k3s-down.yml

ubuntu-k3s-up:
	ansible-playbook $(CHECK_OPTION) ubuntu-k3s-up.yml

ubuntu-k3s-down:
	ansible-playbook $(CHECK_OPTION) ubuntu-k3s-down.yml

clean:
	rm -f kubeconfig* node-token *.img
