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
class apache_test (
  $base_dir,
  #  $vhost_dir = "${base_dir}/conf/vhost.d",
  #$proxy_dir = "${base_dir}/conf/proxy.d",
  #$ssl_dir   = "${base_dir}/ssl",
  

  ) {
  
  File {
    owner => 'root',
    group => 'root',
    mode  => '0755',
  }
    
  file { '/app':
    ensure => directory,
  }
  
  #file { '/app/apache':
  #  ensure => directory,
  #  require => File['/app'],
  #}
  
  file { $base_dir:
    ensure => directory,
    require => File['/app/apache'],
  }
  
  #file { "${base_dir}/conf":
  #  ensure => directory,
  #  require => File[$base_dir],
  #}
  
  #file { $vhost_dir:
  #  ensure => directory,
  #  require => File["${base_dir}/conf"],
  #}
  #
}
