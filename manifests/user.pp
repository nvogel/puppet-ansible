# = Class : ansible::user
#
# == Summary
#
# Create an ansible user
#
# == Description
#
# This class create an 'ansible' user :
#
# - create rsa ssh keys if needed
# - enable sudo (optional)
# - define the commands you can run with sudo (optional)
#
# The password is not managed by puppet.
# By default, it's not possible to log as the ansible user with a password.
#
# == Parameters
#
# [*sudo*]
# Set to 'enable' if you want to authorize ansible user to behave like root
#
# [*sudo_command*]
# If sudo is enabled, this optionnal parameter define a list of one or more
# command names or directories that can be run with sudo.
# See Cmnd_List definition from sudoers(5) for the syntax.
# By default, all commands can be run via sudo.
#
# == Examples
#
# class { 'ansible::user':
#   sudo => 'enable'
# }
#
# or
#
# class { 'ansible::user':
#   sudo         => 'enable',
#   sudo_command => '/usr/bin/supervisorctl, /etc/init.d/apache2'
# }
#
# or
#
# include ansible::user
#
class ansible::user(
  $sudo = 'disable',
  $sudo_command = 'ALL'
) {

  # Create an 'ansible' user
  user { 'ansible':
    ensure     => present,
    comment    => 'ansible',
    managehome => true,
    shell      => '/bin/bash',
    home       => '/home/ansible'
  }

  # Create a .ssh directory for 'ansible' user
  file { '/home/ansible/.ssh' :
    ensure  => directory,
    mode    => '0700',
    owner   => 'ansible',
    group   => 'ansible',
    require => User[ansible],
    notify  => Exec[home_ansible_ssh_keygen]
  }

  # Generate if not existant rsa keys for the 'ansible' user
  exec { 'home_ansible_ssh_keygen':
    path    => ['/usr/bin'],
    command => 'ssh-keygen -t rsa -q -f /home/ansible/.ssh/id_rsa -N ""',
    creates => '/home/ansible/.ssh/id_rsa',
    user    => 'ansible'
  }

  # Sudo configuration
  if $ansible::user::sudo == 'enable' {

    # Install sudo
    ensure_packages([ 'sudo' ])

    file { '/etc/sudoers.d/ansible' :
      ensure  => file,
      mode    => '0440',
      owner   => 'root',
      group   => 'root',
      content => template('ansible/sudo.erb'),
      require => Package['sudo']
    }
  }
}
