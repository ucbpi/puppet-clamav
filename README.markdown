# ClamAV Puppet Module #

This module manages clamav by installing required software, and setting up
scan jobs that can be run via cron or manually on the target host.

Examples
--------

Setup a clamav scan that scans everything except the /sys and /dev, and does
not run on a schedule.

     clamav::scan { 'all-but-sys-and-dev':
       exclude_dir => ['(?i)/^\/(sys|dev)/'],
       scan        => ['/'],
       enable      => false,
     }

License
-------

See LICENSE file

Copyright
---------

Copyright &copy; 2014 The Regents of the University of California

Contact
-------

Aaron Russo <arusso@berkeley.edu>

Support
-------

Please log tickets and issues at the
[Projects site](https://github.com/arusso/puppet-clamav/issues/)
