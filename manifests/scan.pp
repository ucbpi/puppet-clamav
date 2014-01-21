# Class: clamav::scan
#
# Setup a scan
#
define clamav::scan (
  $copy = false,
  $exclude = [ ],
  $exclude_dir = [ ],
  $flags = '',
  $include = [ ],
  $include_dir = [ ],
  $move = false,
  $recursive = false,
  $scan = [ ],
) {
  file { [ '/etc/clamav', '/etc/clamav/scans' ]:
    ensure => directory,
    owner  => 'clam',
  }
  file { "/etc/clamav/scans/${title}":
    ensure  => present,
    owner   => 'clam',
    mode    => '0500',
    content => template('clamav/scan.sh.erb'),
  }
}
