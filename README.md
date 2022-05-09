# dev-provisioning

## Usage
```sh
$ make PLAYBOOK_OPTS="--ask-become-pass --skip-tags tex"
```

## Test with Vagrant
```bash
$ cd ./vagrant/
$ vagrant up --provisioning

# clean
$ vagrant halt
$ vagrant destroy
```
