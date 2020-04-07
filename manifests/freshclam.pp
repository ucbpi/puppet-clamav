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
  $command = hiera('clamav::freshclam::command','/usr/bin/freshclam --quiet'),
  $proxy_server = hiera('clamav::freshclam::proxy_server',''),
  $proxy_port = hiera('clamav::freshclam::proxy_port',''),
  $proxy_username = hiera('clamav::freshclam::proxy_username',''),
  $proxy_password = hiera('clamav::freshclam::proxy_password',''),
  $logfile = '/var/log/clamav/freshclam.log',
) {
  include clamav::params

  file { "$clamav::params::freshclam_config_file":
    ensure  => present,
    owner   => $clamav::params::user,
    mode    => $clamav::params::freshclam_config_file_mode,
    content => template('clamav/freshclam.conf.erb'),
    require => Package[$clamav::params::package],
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
    require => File[ "$clamav::params::freshclam_config_file"],
  }

  # $enable means the cron job
  if ( $osfamily == 'Debian' and $enable == false ) {
    service { "clamav-freshclam":
    	ensure    => running,
    	subscribe => File["$clamav::params::freshclam_config_file"],
    }
  }

  # remove the freshclam cron that is installed with the package
  file { '/etc/cron.daily/freshclam':
    ensure  => absent,
    require => File[ "$clamav::params::freshclam_config_file"],
  }

  file { '/etc/cron.d/clamav-update':
    ensure  => absent,
    require => File[ "$clamav::params::freshclam_config_file"],
  }

  # ensure proper permissions on our logfile
  file { $logfile:
    ensure  => present,
    owner   => $clamav::params::user,
    mode    => '0644',
    require => File[ "$clamav::params::freshclam_config_file"],
  }
}
