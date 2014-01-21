# Class: clamav
#
# Install clamav
#
class clamav {
  package { 'clamav': ensure => installed }
}
