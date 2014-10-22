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
    Debian: {
      #Set some variables
    }
    default : {
      fail("Unsupported platform: ${::osfamily}/${::operatingsystem}")
    }
  }

}
