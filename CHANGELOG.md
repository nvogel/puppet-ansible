# Change Log
All notable changes to this project will be documented in this file.

## 2014-12-26 Release 3.0.0
### Improvements
- you can install ansible with the default package provider
- you can install ansible with pip on redhat family operating system

### Breaking Changes
- the ansible::master::provider parameter doesn't support anymore the apt value
- the master ansible user has by default sudo capability (like an ansible node)

## 2014-12-07 Release 2.1.0
### Improvements
- add support for installing ansible with apt
- add support for choosing the version of ansible
- add a playbooks class for managing ansible configuration and playbooks

## 2014-10-22 Release 2.0.1
### Changes
- install python-crypto package when installing ansible on the master (FIX #6)
- add support for older version of facter (FIX #7)

## 2014-10-16 Release 2.0.0
### Improvements
- add an ansible class for managing both master and node
- add a password parameter to the ansible::user class
- add a provider parameter to the ansible::master class
- add an ansible::params class

### Breaking Changes
- change default password for the ansible user account (FIX #4)
- limit module use to the debian familly operating systems

### Dependency

- change the minimal version needed for the puppetlabs-stdlib module (4.2.2)

## 2014-07-12 Release 1.1.1
### Improvements
- avoid duplicate for /etc/ssh/ssh_known_hosts resource

## 2014-02-07 Release 1.1.0
### Improvements
- install the last version of ansible on the master host

## 2013-07-13 Release 1.0.0
### Improvements
- create an user ansible
- ansible user can optionally run commands with sudo
- custom fact for the public rsa key of the ansible user
- export host keys from the ansible nodes
- export ansible user public key from the ansible master node
- manage ssh_know_hosts on the master node
- manage authorized_keys for the ansible user on the ansible nodes
- compatible with multiple master hosts
