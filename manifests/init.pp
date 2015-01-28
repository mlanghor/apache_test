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
  $base_dir        = '/app/apache',
  $vhost_dir       = "${base_dir}/${instance_name}/conf/vhost.d",
  $proxy_dir       = "${base_dir}/${instance_name}/conf/proxy.d",
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
  $instance_name   = undef,

  ) {

  File {
    owner => 'root',
    group => 'root',
    mode  => '0755',
  }

  file { $base_dir:
    ensure => directory,
  }

  file { "${base_dir}/${instance_name}":
    ensure => directory,
    require => $base_dir,
  }

  file { "${base_dir}/${instance_name}/conf":
    ensure  => directory,
    require => File[$base_dir],
  }

  file { $vhost_dir:
    ensure  => directory,
    require => File["${base_dir}/${instance_name}/conf"],
  }

  file { "${base_dir}/${instance_name}/conf/httpd.conf":
    ensure  => file,
    require => File["${base_dir}/${instance_name}/conf"],
    content => template("apache_test/${httpd_template}"),
    mode    => '0640',
  }
}
