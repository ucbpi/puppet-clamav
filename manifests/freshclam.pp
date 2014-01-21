# == Class: clamav::freshclam
#
# Configure freshclam to update clamav virus definitions
#
class clamav::freshclam (
  $proxy_server = '',
  $proxy_port = '',
  $proxy_username = '',
  $proxy_password = '',
) {
  file { '/etc/freshclam.conf':
    ensure  => present,
    owner   => 'clam',
    mode    => '0400',
    content => template('clamav/freshclam.conf.erb'),
  }
}
