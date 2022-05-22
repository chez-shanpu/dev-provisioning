SHELL:=/bin/bash

UNAME=$(shell uname)
PLAYBOOK_OPTS="-vvv"

ANSIBLE_LINT_EXCLUDE="-x indentation"

brew-Linux:
ifeq (, $(shell which brew))
	curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | /bin/bash
	test -d ~/.linuxbrew && eval $(~/.linuxbrew/bin/brew shellenv)
	test -d /home/linuxbrew/.linuxbrew && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
	test -r ~/.bash_profile && echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.bash_profile
	echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.profile
else
	@echo "linuxbrew is already exits."
endif

brew-Darwin:
ifeq (, $(shell which brew))
	 curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | /bin/bash
else
	@echo "homebrew is already exits."
endif

.PHONY: brew
brew: brew-$(UNAME)

.PHONY: age
age: 
	brew install age

python-Linux:
	sudo apt update
	sudo apt install -y python3
	sudo apt upgrade -y python3

python-Darwin:
	brew install python

.PHONY: python
python: python-$(UNAME)

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
	ansible-lint $(ANSIBLE_LINT_EXCLUDE) $(wildcard ./*/*/*/*.yaml)

.PHONY: provision
provision:
	ansible-playbook $(PLAYBOOK_OPTS) -e "ansible_user=$(shell whoami)" ./dev-provisioning.yaml

.PHONY: dep
dep: brew age python ansible

.PHONY: all
all: dep lint provision

.DEFAULT_GOAL=all
