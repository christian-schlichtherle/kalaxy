.PHONY: up down clean

up down:
	ansible-playbook $(OPTS) $@.yaml

clean:
	rm -rf build
