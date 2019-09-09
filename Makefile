.PHONY: up down clean

up down:
	ansible-playbook $(OPTS) $@.yml

clean:
	rm -rf build
