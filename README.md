# dev-provisioning

## Usage
```sh
$ make PLAYBOOK_OPTS="--ask-become-pass"
```

## Test with Vagrant
```bash
$ cd ./vagrant/
$ vagrant up --provisioning

# clean
$ vagrant halt
$ vagrant destroy
```