ANSIBLE_PLAYBOOK_LIMIT ?= $(LIMIT)
ANSIBLE_PLAYBOOK_OPTS ?= $(if $(OPTS), $(OPTS), $(ANSIBLE_PLAYBOOK_LIMIT:%=--limit=%))

.PHONY: up down
up down:
	@date '+# Start time: %+'
	time ansible-playbook $(ANSIBLE_PLAYBOOK_OPTS) $@.yaml
	@date '+# Finish time: %+'

.PHONY: clean
clean:
	rm -rf build
