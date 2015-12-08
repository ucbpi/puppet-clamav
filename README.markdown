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

Add signature and file whitelist entries in `/var/lib/clamav/local.ign2`,
`/var/lib/clamav/local.sfp`, and `/var/lib/clamav/local.fp`:

    class { 'clamav':
      whitelist_sig => [
	    'ClamAV-Test-Signature',
		'Eicar-Test-Signature:bc356bae4c42f19a3de16e333ba3569c',
      ],
	  whitelist_sha => [
        'da39a3ee5e6b4b0d3255bfef95601890afd80709',
        'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855',
      ],
      whitelist_md5 => [ 'd41d8cd98f00b204e9800998ecf8427e' ]
	}


License
-------

See LICENSE file

Copyright
---------

Copyright &copy; 2015 The Regents of the University of California

Contact
-------

Aaron Russo <arusso@berkeley.edu>

Support
-------

Please log tickets and issues at the
[Projects site](https://github.com/arusso/puppet-clamav/issues/)
