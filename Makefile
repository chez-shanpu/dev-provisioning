SHELL:=/bin/bash

UNAME=$(shell uname)
PLAYBOOK_OPTS="-vvv"

brew-Linux:
ifeq (, $(shell which brew))
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	test -d ~/.linuxbrew && eval $(~/.linuxbrew/bin/brew shellenv)
	test -d /home/linuxbrew/.linuxbrew && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
	test -r ~/.bash_profile && echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.bash_profile
	echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.profile
else
	echo "linuxbrew is already exits."
endif

brew-Darwin:
ifeq (, $(shell which brew))
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
	@echo "homebrew is already exits."
endif

.PHONY: brew
brew: brew-$(UNAME)

ansible-Linux:
	sudo apt update
	sudo apt install software-properties-common
	sudo add-apt-repository --yes --update ppa:ansible/ansible
	sudo apt install -y ansible
	sudo apt install -y ansible-lint

ansible-Darwin:
	brew install ansible
	brew install ansible-lint

.PHONY: ansible
ansible: ansible-$(UNAME)
	ansible-galaxy collection install community.general

.PHONY: lint
lint:
	ansible-playbook -v --syntax-check ./dev-provisioning.yaml
	ansible-lint $(wildcard ./*/*/*/*.yaml)

.PHONY: provision
provision:
	ansible-playbook $(PLAYBOOK_OPTS) -e "ansible_user=$(shell whoami)" ./dev-provisioning.yaml

.PHONY: all
all: brew ansible lint provision

.DEFAULT_GOAL=all