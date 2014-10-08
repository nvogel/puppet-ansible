# Change Log
All notable changes to this project will be documented in this file.

## 2014-10-?? Release 2.0.0
### Improvements
- add an ansible class for managing both master and node
- add a password parameter to the ansible::user class
- add a provider parameter to the ansible::master class
- add a ansible::params class

### Breaking Changes
- change default password for the ansible user account (FIX #4)
- limit module use to the debian familly operating systems

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
