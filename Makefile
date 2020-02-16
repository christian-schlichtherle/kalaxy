.PHONY: up down
up down:
	ansible-playbook $(OPTS) $@.yaml

.PHONY: clean
clean:
	rm -rf build
