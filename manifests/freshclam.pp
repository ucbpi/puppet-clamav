# == Class: clamav::freshclam
#
# Configure freshclam to update clamav virus definitions
#
# === Hiera:
#
# <code>clamav::freshclam::enable</code>: true/false
# <code>clamav::freshclam::minute</code>: 0-59
# <code>clamav::freshclam::hour</code>: 0-23
# <code>clamav::freshclam::command</code>: command to initiate freshclam
# <code>clamav::freshclam::proxy_username</code>: http proxy username
# <code>clamav::freshclam::proxy_password</code>: http proxy password
# <code>clamav::freshclam::proxy_port</code>: http proxy port
# <code>clamav::freshclam::proxy_server</code>: http proxy server
#
class clamav::freshclam (
  $enable = hiera('clamav::freshclam::enable',true),
  $minute = hiera('clamav::freshclam::minute',fqdn_rand(59)),
  $hour = hiera('clamav::freshclam::hour',fqdn_rand(23)),
  $command = hiera('clamav::freshclam::command','/usr/bin/freshclam'),
  $proxy_server = hiera('clamav::freshclam::proxy_server',''),
  $proxy_port = hiera('clamav::freshclam::proxy_port',''),
  $proxy_username = hiera('clamav::freshclam::proxy_username',''),
  $proxy_password = hiera('clamav::freshclam::proxy_password',''),
) {
  include clamav::params

  file { '/etc/freshclam.conf':
    ensure  => present,
    owner   => $clamav::params::user,
    mode    => '0400',
    content => template('clamav/freshclam.conf.erb'),
  }

  $cron_ensure = $enable ? {
    true    => 'present',
    default => 'absent',
  }
  cron { 'clamav-freshclam':
    ensure  => $cron_ensure,
    command => $command,
    minute  => $minute,
    hour    => $hour,
    require => File['/etc/freshclam.conf'],
  }
}
