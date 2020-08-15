.PHONY: up down
up down:
	@date '+# Start time: %+'
	time ansible-playbook $(OPTS) $@.yaml
	@date '+# Finish time: %+'

.PHONY: clean
clean:
	rm -rf build
