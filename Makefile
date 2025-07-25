SHELL:=/bin/bash

UNAME=$(shell uname)
PLAYBOOK_OPTS="-vvv"

ANSIBLE_LINT_EXCLUDE="-x indentation,unnamed-task,yaml[indentation]"

brew-Linux:
	@if ! command -v brew &> /dev/null; then \
		echo "Installing Homebrew for Linux..."; \
		/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; \
		echo >> ~/.bashrc; \
		echo 'eval "$$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.bashrc; \
		eval "$$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"; \
		sudo apt-get install -y build-essential; \
	else \
		echo "Homebrew is already installed"; \
	fi

brew-Darwin:
	@if ! command -v brew &> /dev/null; then \
		echo "Installing Homebrew for macOS..."; \
		/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; \
		echo 'eval "$$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile; \
		eval "$$(/opt/homebrew/bin/brew shellenv)"; \
	else \
		echo "Homebrew is already installed"; \
	fi

.PHONY: brew
brew: brew-$(UNAME)

.PHONY: age
age: 
	brew install age

python-Linux:
	sudo apt-get update
	sudo apt-get install -y python3
	sudo apt-get upgrade -y python3

python-Darwin:
	brew install python

.PHONY: python
python: python-$(UNAME)

.PHONY: ansible
ansible:
	brew install ansible
	brew install ansible-lint
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
