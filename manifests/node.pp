# = Class : ansible::node
#
# == Summary
#
# Configure a ansible node
#
# == Description
#
# This class enable the following features :
#
# - create an ansible user
# - install/configure sudo
# - export host keys
# - set the authorized_keys file with the public key of the ansible master node
#
# == Parameters
#
# [*master*]
# The fqdn of the master host (**required**)
#
# [*sudo_command*]
# This optional parameter define a list of one or more command names that can
# be run by the ansible user as root.
# See Cmnd_List definition from sudoers(5) for the syntax.
# By default, the value is ALL so all commands can be run as root via sudo.
#
# == Example
#
# class { 'ansible::node' :
#   master  => 'master.fqdn.tld'
# }
#
# or
#
# class { 'ansible::node' :
#   master       => 'master.fqdn.tld',
#   sudo_command => '/etc/init.d/varnish, /etc/init.d/pound'
# }
#
class ansible::node(
  $master = 'none',
  $sudo_command = 'ALL'
){

  if $ansible::node::master == 'none' {
    fail('master parameter must be set')
  }

  # Export host key to store config
  @@sshkey { "ansible_${::fqdn}_rsa":
    host_aliases => [ $::fqdn, $::hostname, $::ipaddress ],
    type         => 'ssh-rsa',
    key          => $::sshrsakey,
    tag          => "ansible_node_${ansible::node::master}_rsa"
  }

  # Authorize master host to connect via ssh by colleting its public key
  Ssh_authorized_key <<| tag == "ansible_master_${ansible::node::master}" |>>

  # Create ansible user with sudo
  class { 'ansible::user' :
    sudo         => 'enable',
    sudo_command => $ansible::node::sudo_command
  }

}
