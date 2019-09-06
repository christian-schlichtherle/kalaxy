#CHECK_OPTION = --check

#LIMIT_OPTION = --limit=k8s_masters,k8s_workers

.PHONY: up down clean

up:
	ansible-playbook $(CHECK_OPTION) $(LIMIT_OPTION) up.yml

down:
	ansible-playbook $(CHECK_OPTION) $(LIMIT_OPTION) down.yml

clean:
	rm -rf build
