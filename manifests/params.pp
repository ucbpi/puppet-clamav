class clamav::params {
  case $::osfamily {
    'Debian': {
      $user = 'clamav'
      $clamscan_bin = '/usr/bin/clamscan'
    }
    default: {
      $user = 'clam'
      $clamscan_bin = '/usr/bin/clamscan'
    }
  }

}
