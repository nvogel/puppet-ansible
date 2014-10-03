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

  case $::osfamily {
    Debian: {
      #Set some variables
    }
    default : {
      fail("Unsupported platform: ${::osfamily}/${::operatingsystem}")
    }
  }

}
