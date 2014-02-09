# Ansible puppet module

## Definitions

In the following :

 - the **Ansible master** is the host where Ansible is installed
 - the **Ansible nodes** are the hosts managed by the ansible master host

## Description

The goals of the ansible puppet module are :

 - to install ansible on the ansible master
 - to allow ssh connections from the ansible master to a pool of ansible nodes 

The module use **public key authentication** and manage the **/etc/ssh/ssh_known_hosts** file of the ansible master.

On all hosts, the module deploy an user **ansible**.

The ansible user on the master is able to run commands on the ansible nodes as **root** with **sudo**.
If needed, you can deploy python packages needed for ansible modules with ansible itself :

    su - ansible
    ansible 'all' --sudo -m shell -a 'aptitude -y install python-apt'

## Requirements

A puppet master with store config enable, because this module use exported ressources.

This module is created for Debian (squeeze/wheezy) and compatible with puppet 2.7+.

This module use puppetlabs-stdlib.

## Installation

### With git

In your modules directory on the puppet master :

    git clone git://github.com/nvogel/puppet-ansible.git ansible
    git clone git://github.com/puppetlabs/puppetlabs-stdlib.git stdlib

## How to use the puppet ansible module

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

You're welcome to propose enhancements or submit bug reports (even typos).

### Branch management

Build status on branch master : [![Build Status](https://travis-ci.org/nvogel/puppet-ansible.png?branch=master)](https://travis-ci.org/nvogel/puppet-ansible)

The master branch corresponds to the release under development.
All stable release are tagged.

### Testing Requirements

#### Software required

 - rake
 - puppet
 - rspec-puppet
 - puppetlabs_spec_helper
 - puppet-syntax
 - puppet-lint

### How to run syntax, lint and rspec

    rake test

#### How to check the syntax

    rake syntax

#### How to lint

    rake lint

#### How to run rspec on the manifests

    rake spec

#### How to generate the documentation of the module

    mkdir /tmp/doc
    ln -s /path/to/module/directory/ansible /tmp/doc
    touch /tmp/doc/manifest
    puppet doc --charset UTF-8 --outputdir /path/to/ansible_doc --mode rdoc --manifest /tmp/doc/manifest --modulepath /tmp/doc &> /dev/null && echo 'OK'

## Licence

Puppet ansible module is released under the MIT License. Check the LICENSE file for details.

## References

- [puppet](http://puppetlabs.com)
- [ansible](http://www.ansibleworks.com)
