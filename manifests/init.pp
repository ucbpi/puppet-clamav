# Class: clamav
#
# Install clamav
#
class clamav (
  $whitelist_sig = [],
  $whitelist_sha = [],
  $whitelist_md5 = [],
  $package_ensure = $clamav::params::package_ensure,
) inherits clamav::params {
  include clamav::package
  include clamav::params

  validate_array($whitelist_sig)
  validate_array($whitelist_sha)
  validate_array($whitelist_md5)

  $whitelist_sig_count = count($whitelist_sig)
  $whitelist_sha_count = count($whitelist_sha)
  $whitelist_md5_count = count($whitelist_md5)

  $whitelist_sig_ensure = $whitelist_sig_count ? {
    0       => absent,
    default => file,
  }
  $whitelist_sha_ensure = $whitelist_sha_count ? {
    0       => absent,
    default => file,
  }
  $whitelist_md5_ensure = $whitelist_md5_count ? {
    0       => absent,
    default => file,
  }

  File {
    owner   => $clamav::params::user,
    group   => $clamav::params::user,
    require => Class['clamav::package'],
  }

  file { [ '/etc/clamav', '/etc/clamav/scans' ]:
    ensure  => directory,
  }

  file { '/var/lib/clamav/local.ign2':
    ensure  => $whitelist_sig_ensure,
    content => template('clamav/whitelist.ign2.erb')
  }

  file { '/var/lib/clamav/local.sfp':
    ensure  => $whitelist_sha_ensure,
    content => template('clamav/whitelist.sfp.erb')
  }

  file { '/var/lib/clamav/local.fp':
    ensure  => $whitelist_md5_ensure,
    content => template('clamav/whitelist.fp.erb')
  }

  file { '/var/log/clamav':
      ensure => directory,
  }
}
