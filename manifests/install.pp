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
# Provider (**Default : pip**) (**Optional**)
# Supported values :
#  Any value supported by the provider attribute of the puppet package type
# Recommended values :
#   **pip** : install ansible via pip
#   **apt** : install ansible via apt
#
# == Examples
#
# === Install ansible if not present via the pip provider
#
# include ansible::install
#
# ==== Install ansible 1.7.2 via the pip provider
#
# class { 'ansible::install':
#   version  => '1.7.2',
#   provider => 'pip'
# }
#
# ==== Install last version of ansible
#
# Use the appropriate provider for your platform
#
# class { 'ansible::install':
#   version  => latest,
#   provider => default
# }
#
class ansible::install(
  $version = present,
  $provider= pip,
  ){

  include ansible::params

  # Install packages
  if $ansible::install::provider == 'pip' {

    if empty($ansible::params::ip_dep_package) {
      fail("Unsupported platform: ${::osfamily}/${::operatingsystem} for pip")
    } else {
      ensure_packages($ansible::params::pip_dep_package,
        {'before' => Package['ansible']})

      package { 'ansible':
        ensure   => $ansible::install::version,
        provider => $ansible::install::provider
      }
    }
  } else {
    # Install ansible
    package { 'ansible':
      ensure   => $ansible::install::version
    }
  }

}
