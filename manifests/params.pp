class clamav::params {
  case $::osfamily {
    'Debian': {
      $user = 'clamav'
      $clamscan_bin = '/usr/bin/clamscan'
      $freshclam_config_file = '/etc/clamav/freshclam.conf'
      $freshclam_config_file_mode = '444'
    }
    'RedHat': {
    	$user = $facts['os']['release']['major'] ? {
	  6       => 'clam',
	  default => 'root',
	}
      $clamscan_bin = '/usr/bin/clamscan'
      $freshclam_config_file = '/etc/freshclam.conf'
      $freshclam_config_file_mode = '400'
    }
    default: {
      $user = 'clam'
      $clamscan_bin = '/usr/bin/clamscan'
      $freshclam_config_file = '/etc/freshclam.conf'
      $freshclam_config_file_mode = '400'
    }
  }

  $package = 'clamav'
  $package_ensure = present

  $clamd_config_file = '/etc/clamd.conf'
  $clamd_service_name = 'clamd'
  $clamd_service_enable = true
  $clamd_service_ensure = 'running'
  $clamd_package_name = 'clamd'
  $clamd_log_file = '/var/log/clamav/clamd.log'
  $clamd_log_file_unlock = 'no'
  $clamd_log_file_max_size = '0'
  $clamd_log_time = 'yes'
  $clamd_log_clean = 'no'
  $clamd_log_syslog = 'yes'
  $clamd_log_facility = 'LOG_LOCAL6'
  $clamd_log_verbose = 'no'
  $clamd_log_rotate = 'no'
  $clamd_extended_detection_info = 'no'
  $clamd_pid_file = '/var/run/clamav/clamd.pid'
  $clamd_temporary_directory = '/var/tmp'
  $clamd_database_directory = '/var/lib/clamav'
  $clamd_official_database_only = 'no'
  $clamd_local_socket = '/var/run/clamav/clamd.sock'
  $clamd_local_socket_group = 'UNSET'
  $clamd_local_socket_mode = 'UNSET'
  $clamd_fix_stale_socket = 'yes'
  $clamd_tcp_socket = '3310'
  $clamd_tcp_addr = [ '127.0.0.1' ]
  $clamd_max_connection_queue_length = '30'
  $clamd_stream_max_length = '10M'
  $clamd_stream_min_port = '30000'
  $clamd_stream_max_port = '32000'
  $clamd_max_threads = '50'
  $clamd_read_timeout = '300'
  $clamd_command_read_timeout = '5'
  $clamd_send_buf_timeout = '500'
  $clamd_max_queue = '100'
  $clamd_idle_timeout = '30'
  $clamd_exclude_path = [ ]
  $clamd_max_directory_recursion = '15'
  $clamd_follow_directory_symlinks = 'no'
  $clamd_follow_file_symlinks = 'no'
  $clamd_cross_filesystems = 'yes'
  $clamd_self_check = '600'
  $clamd_virus_event = 'no'
  $clamd_user = 'clam'
  $clamd_allow_supplementary_groups = 'yes'
  $clamd_exit_on_oom = 'yes'
  $clamd_foreground = 'no'
  $clamd_debug = 'no'
  $clamd_leave_temporary_files = 'no'
  $clamd_allow_all_match_scan = 'yes'
  $clamd_detect_pua = 'no'
  $clamd_exclude_pua = [ ]
  $clamd_include_pua = [ ]
  $clamd_algorithm_detection = 'yes'
  $clamd_force_to_disk = 'no'
  $clamd_disable_cache = 'no'
  $clamd_scan_pe = 'yes'
  $clamd_disable_cert_check = 'no'
  $clamd_scan_elf = 'yes'
  $clamd_detect_broken_executables = 'yes'
  $clamd_scan_ole2 = 'yes'
  $clamd_ole2_block_macros = 'no'
  $clamd_scan_pdf = 'yes'
  $clamd_scan_swf = 'yes'
  $clamd_scan_mail = 'yes'
  $clamd_scan_partial_messages = 'no'
  $clamd_phishing_signatures = 'yes'
  $clamd_phishing_scan_urls = 'yes'
  $clamd_phishing_always_block_ssl_mismatch = 'no'
  $clamd_phishing_always_block_cloak = 'no'
  $clamd_partition_intersection = 'no'
  $clamd_heuristic_scan_precedence = 'no'
  $clamd_structured_data_detection = 'no'
  $clamd_structured_min_credit_card_count = 3
  $clamd_structured_min_ssn_count = 3
  $clamd_structured_ssn_format_normal = 'yes'
  $clamd_structured_ssn_format_stripped = 'no'
  $clamd_scan_html = 'yes'
  $clamd_scan_archive = 'yes'
  $clamd_archive_block_encrypted = 'no'
  $clamd_max_scan_size = '100M'
  $clamd_max_file_size = '25M'
  $clamd_max_recursion = '16'
  $clamd_max_files = '10000'
  $clamd_max_embedded_pe = '10M'
  $clamd_max_html_normalize = '10M'
  $clamd_html_no_tags = '2M'
  $clamd_max_script_normalize = '5M'
  $clamd_max_zip_type_rcg = '1M'
  $clamd_max_partitions = '50'
  $clamd_max_icons_pe = '100'
  $clamd_scan_on_access = 'no'
  $clamd_on_access_max_file_size = '10M'
  $clamd_on_access_include_path = [ ]
  $clamd_on_access_exclude_path = [ ]
  $clamd_on_access_exclude_uid = [ '0' ]
  $clamd_bytecode = 'yes'
  $clamd_bytecode_security = 'TrustSigned'
  $clamd_bytecode_timeout = '5000'
  $clamd_stats_enabled = 'no'
  $clamd_stats_pe_disabled = 'no'
  $clamd_stats_host_id = 'auto'
  $clamd_stats_timeout = '10'
}
