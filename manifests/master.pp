# = Class : ansible::master
#
# == Summary
#
# Create an ansible *master* host
#
# == Description
#
# This class enable the following features :
#
# - create an ansible user with ssh rsa keys
# - install/configure sudo
# - the ansible user public key is exported to all ansible nodes
# - add all ansible nodes of the pool to the sshd_known_hosts file
# - install ansible (or not)
#
# == Parameters
#
# [*provider*]
# Provider name used to install Ansible (**Default : pip**) (**Optional**)
# Supported values (**string**) :
#   **pip** : install ansible via pip
#   **automatic** : install ansible via the appropriate platform provider
#   **manual** : don't install anything
#
# [*common_id*]
# A common ID between master and managed nodes to exachange exported resources
# under. Defaults to `$fqdn` on the master side, must be set on the node side.
# Must match between master and nodes for the module to work.
#
# == Examples
#
# === Deploy an ansible master
#
#  include ansible::master
#
# === Deploy an ansible master without ansible
#
# class { 'ansible::master' :
#   provider  => 'manual'
# }
#
# === Deploy an ansible master via the default provider
#
# class { 'ansible::master' :
#   provider  => 'automatic',
# }
#
# === Deploy an ansible master using a different resource collection ID
#
# class { 'ansible::master' :
#   common_id => 'ansible01',
# }
#
class ansible::master(
  $provider = 'pip',
  $common_id = $::fqdn,
  ){

  include ansible::params

  # Create ansible user with sudo
  class { 'ansible::user' :
    sudo => 'enable'
  }

  # Install Ansible
  case $ansible::master::provider {
    'pip': {
      include ansible::install
    }
    'automatic': {
      class { 'ansible::install':
        provider => 'automatic'
      }
    }
    'manual': {
      # don't install anything on the master node
    }
    default : {
      fail('Unsupported provider')
    }
  }

  # Export ansible user public key if fact is defined
  if ( $::ansible_user_key != undef ) {
    @@ssh_authorized_key { "ansible_user_${common_id}_rsa":
      key  => $::ansible_user_key,
      user => 'ansible',
      type => 'rsa',
      tag  => "ansible_master_${common_id}"
    }
  }

  # Collect ssh host keys from nodes
  Sshkey <<| tag == "ansible_node_${common_id}_rsa" |>>

  # Fix /etc/ssh/ssh_known_hosts permission
  # See http://projects.puppetlabs.com/issues/2014
  ensure_resource('file', '/etc/ssh/ssh_known_hosts', {
      'ensure'  => 'file',
      'mode'    => '0644',
    }
  )

}
