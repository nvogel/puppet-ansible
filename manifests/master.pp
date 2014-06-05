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
# - the ansible user public key is exported to all ansible nodes
# - add all ansible nodes of the pool to the sshd_known_hosts file
# - install ansible
#
# == Example
#
#  include ansible::master
#
class ansible::master {

  # Create ansible user
  include ansible::user

  # Install Ansible
  include ansible::install

  # Export ansible user public key if fact is defined
  if ( $::ansible_user_key != undef ) {
    @@ssh_authorized_key { "ansible_user_${::fqdn}_rsa":
      key  => $::ansible_user_key,
      user => 'ansible',
      type => 'rsa',
      tag  => "ansible_master_${::fqdn}"
    }
  }

  # Collect ssh host keys from nodes
  Sshkey <<| tag == "ansible_node_${::fqdn}_rsa" |>>

  # Fix /etc/ssh/ssh_known_hosts permission
  # See http://projects.puppetlabs.com/issues/2014
  ensure_resource('file', '/etc/ssh/ssh_known_hosts', {
      'ensure'  => 'file',
      'mode'    => '0644',
    }
  )

}
