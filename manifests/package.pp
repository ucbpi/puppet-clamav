# == Class: clamav::package
#
# Installs the clamav package
#
class clamav::package {
  include clamav::params

  package { $clamav::params::package: ensure => $clamav::package_ensure }
}
