# = Class : ansible::params
#
# == Summary
#
# Ansible parameters
#
# == Description
#
#
class ansible::params {

  # Support for Facter < 1.6.1
  if $::osfamily == undef {
    case $::operatingsystem {
      'ubuntu', 'debian': {
        $operatingsystemfamily = 'Debian'
      }
      default: {
        $osfamily = $::operatingsystem
      }
    }
  } else {
    $operatingsystemfamily = $::osfamily
  }

  case $operatingsystemfamily {
    'Debian': {
      $pip_dep_package = ['python-yaml','python-jinja2','python-paramiko',
      'python-pkg-resources','python-pip','python-crypto','python-markupsafe',
      'python-httplib2']
    }
    'Redhat': {
      $pip_dep_package = ['PyYAML','libyaml','python-babel','python-crypto',
      'python-ecdsa','python-httplib2','python-jinja2','python-keyczar',
      'python-markupsafe','python-paramiko','python-pyasn1','python-six',
      'python-pip']
    }
    default : {
      $pip_dep_package = []
    }
  }

}
