# = Class : ansible::install
#
# == Summary
#
# Install Ansible
#
# == Description
#
# This class install ansible via pip
#
# == Parameter
#
# [*version*]
# Version of ansible (**Default : present**) (**Optional**)
# Supported values :
#  Any value supported by the puppet package type with the pip provider (latest, present, x.y.z, ...)
#
# == Examples
#
# === Install ansible if not present
#
# include ansible::install
#
# ==== Install the last version of ansible
#
# class { 'ansible::install':
#   version => latest
# }
#
#
#
class ansible::install(
  $version = present,
  $provider= pip,
  ){

  include ansible::params

  # Install packages
  if $ansible::install::provider == 'pip' {
    ensure_packages(['python-yaml','python-jinja2','python-paramiko','python-markupsafe','python-pip','python-crypto'])
  }

  # Install ansible
  package { 'ansible':
    ensure   => $ansible::install::version,
    provider => $ansible::install::provider
  }

}
