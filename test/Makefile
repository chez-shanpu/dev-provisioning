SHELL:=/bin/bash

VM_NAME=dev-provisioning
VM_OPTS=--arch x86_64
VM_WORKDIR=--workdir ~/ghq/github.com/chez-shanpu/dev-provisioning/

.PHONY: lima
lima:
ifeq (, $(shell which limactl))
	brew install lima
else
	@echo "lima is already exits."
endif

.PHONY: setup
setup: lima
	limactl create $(VM_OPTS) --name=$(VM_NAME) template://default
	limactl start $(VM_NAME)
	limactl shell $(VM_WORKDIR) $(VM_NAME) sudo apt-get update
	limactl shell $(VM_WORKDIR) $(VM_NAME) sudo apt-get install -y make

.PHONY: ssh
ssh:
	limactl shell $(VM_WORKDIR) $(VM_NAME)

.PHONY: test
test:
	limactl shell $(VM_WORKDIR) $(VM_NAME) make dep
	limactl shell $(VM_WORKDIR) $(VM_NAME) make provision

.PHONY: clean
clean:
	-limactl stop $(VM_NAME)
	limactl delete $(VM_NAME)

.PHONY: all
all: lima setup

.DEFAULT_GOAL=all
