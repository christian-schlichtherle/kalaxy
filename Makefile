#CHECK_OPTION = --check

.PHONY: setup

setup:
	ansible-playbook $(CHECK_OPTION) playbook.yml
