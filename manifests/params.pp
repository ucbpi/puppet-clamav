class clamav::params {
  case $::osfamily {
    'Debian': {
      $user = 'clamav'
    }
    default: {
      $user = 'clam'
    }
  }

}
