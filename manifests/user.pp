# = Class : ansible::user
#
# == Summary
#
# Create an ansible user
#
# == Description
#
# This class enable the following features :
#
# - create an ansible user
# - create rsa ssh keys
# - run commands with sudo (optional)
#
# The password is not managed by puppet.
# By default, it's not possible to log as the ansible user with a password.
#
# == Parameter
#
# [*sudo*]
# set to 'enable' if you want to authorize ansible user to behave like root
#
# == Examples
#
# class { 'ansible::user':
#   sudo => 'enable'
# }
#
# or
#
# include ansible::user
#
class ansible::user(
  $sudo = 'disable'
) {

  # Create an 'ansible' user
  user { 'ansible':
    ensure     => present,
    comment    => 'ansible',
    managehome => true,
    shell      => '/bin/bash',
    home       => '/home/ansible'
  }

  # Create a .ssh directory for the 'ansible' user
  file { '/home/ansible/.ssh' :
    ensure  => directory,
    mode    => '0700',
    owner   => 'ansible',
    group   => 'ansible',
    require => User[ansible],
    notify  => Exec[home_ansible_ssh_keygen]
  }

  # Generate rsa keys for the 'ansible' user
  exec { 'home_ansible_ssh_keygen':
    path    => ['/usr/bin'],
    command => 'ssh-keygen -t rsa -q -f /home/ansible/.ssh/id_rsa -N ""',
    creates => '/home/ansible/.ssh/id_rsa',
    user    => 'ansible'
  }

  # Enable sudo
  if $ansible::user::sudo == 'enable' {

    # Install Sudo if it don't already exist
    ensure_packages([ 'sudo' ])

    # Ansible user can do everything with sudo
    file { '/etc/sudoers.d/ansible' :
      ensure  => file,
      mode    => '0440',
      owner   => 'root',
      group   => 'root',
      content => 'ansible ALL = NOPASSWD : ALL',
      require => Package['sudo']
    }
  }

}
