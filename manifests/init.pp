# = Class : ansible
#
# == Summary
#
# Create an ansible *master* or an ansible *node*
#
# == Description
#
# This class enable the following features :
#
# - create an ansible master node, or
# - create an ansible node wich is associated with a master node
#
# == Parameter
#
# [*ensure*]
# master or node (**Default : master*) (**Optional**)
#
# [*master*]
# The fqdn of the master host (**Required** if the host is an ansible **node**)
#
# == Example
#
# === Create a master node
#
#  include ansible
#
#  or
#
#  class { 'ansible':
#    ensure => master
#  }
#
# === Create an ansible node
#
#  class { 'ansible':
#    ensure => node,
#    master => 'master.fqdn.tld'
#  }
#
class ansible(
  $ensure = 'master',
  $master = false
  ){

  include ansible::params

  if ($ansible::ensure == 'master' and is_bool($ansible::master) and $ansible::master == false) {
    include ansible::master
  }

  if $ansible::ensure == 'node' and is_string($ansible::master) {
    class { 'ansible::node' :
      master  => $ansible::master
    }
  }
}
