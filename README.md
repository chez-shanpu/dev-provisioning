# dev-provisioning

[![Build Status](https://travis-ci.org/chez-shanpu/dev-provisioning.svg?branch=master)](https://travis-ci.org/chez-shanpu/dev-provisioning)

## 使い方
- ansibleをインストールする
```sh
# ubuntu
$ sudo apt-get update
$ sudo apt-get install software-properties-common
$ sudo apt-add-repository --yes --update ppa:ansible/ansible
$ sudo apt-get install ansible
```

- 実行する
```sh
$ ansible-playbook dev-provisioning.yml
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