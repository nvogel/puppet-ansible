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
# [*provider*]
# Provider (**Default : pip**) (**Optional**)
# Supported values :
#   **pip** : install ansible via pip
#   **apt** : install ansible via apt
#
# == Examples
#
# === Install ansible if not present via pip provider
#
# include ansible::install
#
# ==== Install ansible 1.7.2 via pip provider
#
# class { 'ansible::install':
#   version => '1.7.2'
# }
#
# ==== Install last version of ansible via apt
#
# class { 'ansible::install':
#   version  => latest,
#   provider => apt
# }
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
