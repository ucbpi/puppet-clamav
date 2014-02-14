# Class: clamav
#
# Install clamav
#
class clamav {
  include clamav::package
  include clamav::params

  file { [ '/etc/clamav', '/etc/clamav/scans' ]:
    ensure  => directory,
    owner   => $clamav::params::user,
    require => Class['clamav::package']
  }
}
