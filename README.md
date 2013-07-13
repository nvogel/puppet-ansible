# Ansible puppet module

## Description

The main goal of this ansible puppet module is to allow ssh connections
 from one central ansible machine to a pool of managed nodes.

The module use **public key authentication** and manage the **/etc/ssh/ssh_known_hosts** file,
so you've nothing to do except install ansible, and set your hosts inventory.

In order to do that, this module deploy an user **ansible**.
The ansible user is able to run commands as **root** with **sudo** :

      su - ansible
      ansible '*' --sudo -m ping

You can deploy python packages needed for ansible modules with ansible itself :

      ansible 'all' --sudo -m shell -a 'aptitude -y install python-apt'

## Requirements

A puppet master with store config enable, because this module use exported ressources.

This module is only compatible (at this time) with a Debian os and puppet 2.7+.

## How to use the puppet ansible module

### Definitions

 - **Ansible master** is the host where ansible is installed.
 - **Ansible nodes** are the hosts managed by the ansible master host.

### Usage

On the ansible master with a fqdn **master.fqdn.tld** :

  include ansible::master

For each ansible node :

  class { 'ansible::node' :
    master  => 'master.fqdn.tld'
  }

You can have several ansible master hosts, each one will have its own pool of ansible nodes.

You will need to wait 2 runs of the puppet agent to complete the configuration process.

## Developpment

You're welcome to propose enhancements or submit bug reports (even typos on documentation).

### Branch management

Build status on branch master : [![Build Status](https://travis-ci.org/nvogel/puppet-ansible.png?branch=master)](https://travis-ci.org/nvogel/puppet-ansible)

The master branch corresponds to the release under development.
All stable release are tagged.

### Testing Requirements

#### Software required

 - puppet
 - rspec-puppet
 - puppetlabs_spec_helper
 - puppet-lint

#### How to lint

  cd /path/to/module/directory/ansible
  rake lint

#### How to run rspec on the manifests

  cd /path/to/module/directory/ansible
  rake spec

#### How to check the documentation of the module

  mkdir /tmp/doc
  ln -s /path/to/module/directory/ansible /tmp/doc
  touch /tmp/doc/manifest
  puppet doc --charset UTF-8 --outputdir /path/to/ansible_doc --mode rdoc --manifest /tmp/doc/manifest --modulepath /tmp/doc &> /dev/null && echo 'OK'

## References

- [puppet](http://puppetlabs.com/)
- [ansible](http://www.ansibleworks.com/)
- 
