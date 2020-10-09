ANSIBLE_PLAYBOOK_OPTS ?= $(OPTS)

.PHONY: up down
up down:
	@date '+# Start time: %+'
	time ansible-playbook $(ANSIBLE_PLAYBOOK_OPTS) $@.yaml
	@date '+# Finish time: %+'

.PHONY: clean
clean:
	rm -rf build
