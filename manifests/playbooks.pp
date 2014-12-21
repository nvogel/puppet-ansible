# = Class : ansible::playbooks
#
# == Summary
#
# Manage playbooks
#
# == Description
#
# Create a directory for ansible configuration
# This directory is owned by the ansible user
#
# == Parameter
#
# [*location*]
# the playbooks directory path
# (**string**) (**Default : '/etc/ansible' **) (**Optional**)
#
# == Example
#
# === Create the /etc/ansible directory
#
# include ansible::playbooks
#
class ansible::playbooks(
  $location   = '/etc/ansible'
) {

  include ansible::params

  # Create directories for playbooks
  file { '/etc/ansible':
    ensure  => directory,
    owner   => 'ansible',
    group   => 'ansible',
    mode    => '0750',
    path    => $location,
    require => User[ansible]
  }

}
