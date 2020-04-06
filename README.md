# dev-provisioning

## 環境
Ubuntu 18.04.2 <br>
ansible 2.7.8

## 使い方
- ansibleをインストールする
```sh
# ubuntu
$ sudo apt-get update
$ sudo apt-get install software-properties-common
$ sudo apt-add-repository --yes --update ppa:ansible/ansible
$ sudo apt-get install ansible

# Use shell script
$ ./ansible-setup.sh
```

- 実行する
```sh
$ ansible-playbook dev-provisioning.yml --ask-become-pass
```

### Vagrantでの実行
#### 確認済み動作環境
Vagrant 2.2.3

```bash
$ cd ./vagrant/
$ vagrant up --provisioning

# 仮想マシンのリセット
$ vagrant halt
$ vagrant destroy
```