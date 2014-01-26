# Class: clamav
#
# Install clamav
#
class clamav {
  include clamav::package

  file { [ '/etc/clamav', '/etc/clamav/scans' ]:
    ensure  => directory,
    owner   => 'clam',
    require => Class['clamav::package']
  }
}
