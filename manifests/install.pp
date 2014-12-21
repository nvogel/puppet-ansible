# = Class : ansible::install
#
# == Summary
#
# Install Ansible
#
# == Description
#
# This class install ansible
#
# == Parameters
#
# [*version*]
# Version of ansible (**Default : present**) (**Optional**)
# Supported values :
#  Any value supported by the ensure attibute of the puppet package type
#  For example : latest, present, x.y.z
#
# [*provider*]
# Provider (**string**) (**Default : pip**) (**Optional**)
# Supported values :
#   **pip** : install ansible via pip
#   **automatic** : let puppet guess the appropriate provider of the platform
#
# == Examples
#
# === Install ansible if not present via the pip provider
#
# include ansible::install
#
# ==== Install ansible 1.8.2 via the pip provider
#
# class { 'ansible::install':
#   version  => '1.8.2'
# }
#
# ==== Install last version of ansible
#
# Install ansible with the appropriate provider for your platform
#
# class { 'ansible::install':
#   version  => latest,
#   provider => automatic
# }
#
class ansible::install(
  $version = present,
  $provider= pip,
  ){

  include ansible::params

  if $ansible::install::provider == 'pip' {
    # Install ansible with pip
    if empty($ansible::params::pip_dep_package) {
      fail('Unsupported platform for pip install ansible')
    } else {
      ensure_packages($ansible::params::pip_dep_package,
        {'before' => Package['ansible']})

      package { 'ansible':
        ensure   => $ansible::install::version,
        provider => 'pip'
      }
    }
  } else {
    # Install ansible with the default provider
    package { 'ansible':
      ensure   => $ansible::install::version
    }
  }

}
