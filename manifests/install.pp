# = Class : ansible::install
#
# == Summary
#
# Install Ansible
#
# == Description
#
# This class install the last version of ansible via pip
#
# == Examples
#
# include ansible::install
#
class ansible::install {

  include ansible::params

  # Install packages
  ensure_packages(['python-yaml','python-jinja2','python-paramiko','python-markupsafe','python-pip'])

  # Install ansible
  package { 'ansible':
    ensure   => present,
    provider => 'pip'
  }

}
