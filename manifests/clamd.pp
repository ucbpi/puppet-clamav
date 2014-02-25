# == Class: clamav::clamd
#
# Sets up the clamd daemon
#
# === Parameters:
#
#
class clamav::clamd(
  $logfile = '',
  $logtime = '',
  $logsyslog = '',
  $logverbose = '',
  $extendeddetectioninfo = '',
  $logfacility = '',
  $virusevent = '',
   
) {
  include clamav::package
}
