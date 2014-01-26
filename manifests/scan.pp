# Class: clamav::scan
#
# Setup a scan
#
define clamav::scan (
  $action_virus = '',
  $action_error = '',
  $action_ok = '',
  $enable = true,
  $hour = fqdn_rand(23,$title),
  $minute = fqdn_rand(59,$title),
  $month = 'UNSET',
  $monthday = 'UNSET',
  $copy = false,
  $exclude = [ ],
  $exclude_dir = [ ],
  $flags = '',
  $include = [ ],
  $include_dir = [ ],
  $quiet = true,
  $move = false,
  $recursive = false,
  $scan = [ ],
  $scanlog = "/var/log/clamav/scan_${title}",
  $weekday = 'UNSET',
) {
  $scancmd = "/etc/clamav/scans/${title}"
  file { $scancmd:
    ensure  => present,
    owner   => 'clam',
    mode    => '0500',
    content => template('clamav/scan.sh.erb'),
  }

  # setup our scheduled job to run this scan
  $cron_ensure = $enable ? {
    true    => 'present',
    default => 'absent',
  }
  $month_r = $month ? {
    'UNSET' => undef,
    default => $month,
  }
  $monthday_r = $monthday ? {
    'UNSET' => undef,
    default => $monthday,
  }
  $weekday_r = $weekday ? {
    'UNSET' => undef,
    default => $weekday,
  }
  cron { "clamav-scan-${title}":
    ensure   => $cron_ensure,
    command  => $scancmd,
    hour     => $hour,
    minute   => $minute,
    month    => $month_r,
    monthday => $monthday_r,
    weekday  => $weekday_r,
    require  => File[$scancmd],
  }
}
