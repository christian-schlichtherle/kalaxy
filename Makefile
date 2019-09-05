#CHECK_OPTION = --check

.PHONY: up down clean

up:
	ansible-playbook $(CHECK_OPTION) up.yml

down:
	ansible-playbook $(CHECK_OPTION) down.yml

clean:
	rm -rf build
