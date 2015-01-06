# Class: apache_test
#
# This module manages apache_testing
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#
define apache_test (
  $base_dir        = undef,
  $vhost_dir       = "${base_dir}/conf/vhost.d",
  $proxy_dir       = "${base_dir}/conf/proxy.d",
  $ssl_dir         = "${base_dir}/ssl",
  $package_state   = undef,
  $package_name    = undef,
  $user            = 'proxy',
  $group           = 'proxy',
  $purge_vhost_dir = true,
  $purge_ssl_dir   = true,
  $log_level       = 'warn',
  $httpd_template  = 'httpd-2.2-CT.conf.erb',
  $serveradmin    = 'ISOHelpDesk@caiso.com',

  ) {

  File {
    owner => 'root',
    group => 'root',
    mode  => '0755',
  }

  file { $base_dir:
    ensure => directory,
    #  require => File['/app/apache'],
  }

  file { "${base_dir}/conf":
    ensure  => directory,
    require => File[$base_dir],
  }

  file { $vhost_dir:
    ensure  => directory,
    require => File["${base_dir}/conf"],
  }

  file { "${base_dir}/conf/httpd.conf":
    ensure  => file,
    require => File["${base_dir}/conf"],
    content => template("apache_test/${httpd_template}"),
    mode    => '0640',
  }
}
