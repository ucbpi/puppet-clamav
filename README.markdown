# ClamAV Puppet Module #

This module provides mechanisms to manage clamav, allowing for the creation of
scheduled scans via the `clamav::scan` define as well as running the clamd
daemon using the `clamav::clamd` class.

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

Enable clamd:

    include clamav::clamd

Enable clamd and setup on-access scanning

    class { 'clamav::clamd':
      scan_on_access          => 'yes',
      on_access_max_file_size => '15M',
      on_access_exclude_path  => [ '/srv/noscan' ],
      on_access_include_path  => [ '/srv' ],
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
