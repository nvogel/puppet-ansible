# Ansible puppet module

## Definitions

In the following :

 - the **Ansible master** is the host where Ansible is installed and where you run your playbooks
 - the **Ansible nodes** are the hosts managed by the ansible master

## Description

The goals of the ansible puppet module are :

 - to install [Ansible](http://www.ansibleworks.com) on the ansible master
 - to allow ssh connections from the ansible master to a pool of ansible nodes
 - to install and configure sudo on the ansible nodes

The module use **public key authentication** and manage the **/etc/ssh/ssh_known_hosts** file of the ansible master.

On all hosts, an user **ansible** is created.

The ansible user on the master is able to run commands on the ansible nodes as **root** with **sudo**.

## Requirements

A puppet master with store config enable, because this module use exported ressources.

This module is created for Debian (Squeeze/Wheezy) and compatible with puppet (2.7+).

This module use puppetlabs-stdlib (4.1.x).

## Installation from the forge

Go to [nvogel/ansible](http://forge.puppetlabs.com/nvogel/ansible)

## How to use the puppet ansible module

### Puppet side

On the ansible master with a fqdn **master.fqdn.tld** :

```puppet
include ansible::master
```

For each ansible node :

```puppet
class { 'ansible::node' :
  master  => 'master.fqdn.tld'
}
```

You can have several ansible master hosts, each one will have its own pool of ansible nodes.

You have to wait 2 runs of the puppet agent to complete the configuration process.

### Ansible side

On the ansible master host, all you have to do is to use the ansible user.
By default, there is no password for the ansible user so you have to be root to use this account.

```bash
su - ansible
```

On the ansible nodes, the only package installed is **sudo** so you can deploy python packages needed for ansible modules with ansible itself :

```bash
su - ansible
ansible 'all' --sudo -m shell -a 'aptitude -y install python-apt'
```

## Development

### Contributing

You're welcome to propose enhancements or submit bug reports (even typos).

When you perform modifications inside the puppet module :

 - You MUST run the test suite (see Testing section)
 - You MUST write (or update) the test suite
 - You MUST update the documentation

Thanks in advance.

### Branch management

 - Build status on branch master : [![Build Status](https://travis-ci.org/nvogel/puppet-ansible.png?branch=master)](https://travis-ci.org/nvogel/puppet-ansible)
 - Build status on release 1.1.1 : [![Build Status](https://travis-ci.org/nvogel/puppet-ansible.png?branch=v1.1.1)](https://travis-ci.org/nvogel/puppet-ansible)
 - Build status on release 1.1.0 : [![Build Status](https://travis-ci.org/nvogel/puppet-ansible.png?branch=v1.1.0)](https://travis-ci.org/nvogel/puppet-ansible)
 - Build status on release 1.0.0 : [![Build Status](https://travis-ci.org/nvogel/puppet-ansible.png?branch=v1.0.0)](https://travis-ci.org/nvogel/puppet-ansible)

The master branch corresponds to the release under development. Could be unstable.
All stable release are tagged.

### Installation

```bash
gem install bundler
mkdir modules
cd modules
git clone git://github.com/nvogel/puppet-ansible.git ansible
cd ansible
bundle install --path vendor/bundle
```

### Testing
#### How to list the available tasks

```bash
bundle exec rake
```

#### How to run syntax, lint and rspec

```bash
bundle exec rake test
```
##### How to check the syntax

```bash
bundle exec rake syntax
```
##### How to lint

```bash
bundle exec rake lint
```

##### How to run rspec on the manifests

```bash
bundle exec rake spec
```

#### How to run test automatically when you change any of the manifest

```bash
bundle exec guard
```

### How to generate the documentation of the module

```bash
mkdir /tmp/doc
ln -s /path/to/module/directory/ansible /tmp/doc
touch /tmp/doc/manifest
puppet doc --charset UTF-8 --outputdir /path/to/ansible_doc --mode rdoc --manifest /tmp/doc/manifest --modulepath /tmp/doc &> /dev/null && echo 'OK'
```

### Credits

* Nicolas Vogel
* [All contributors](https://github.com/nvogel/puppet-ansible/contributors)

## Licence

Puppet ansible module is released under the MIT License. Check the LICENSE file for details.

## References

- [puppet](http://puppetlabs.com)
- [ansible](http://www.ansibleworks.com)
- [contributing to open-source](https://guides.github.com/activities/contributing-to-open-source)
- [about commit message](http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html)
