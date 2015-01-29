define apache_test::ssl_vhost (
  $base_dir        = '/app/apache',
  $vhost_dir       = "${base_dir}/${instance_name}/conf/vhost.d",
  $proxy_dir       = "${base_dir}/${instance_name}/conf/proxy.d",
  $ssl_dir         = "${base_dir}/${instance_name}/ssl",
  $vhost_ip        = undef,
  $vhost_port      = undef,
  $servername      = undef,
  $docroot         = undef,
  $package_state   = undef,
  $package_name    = undef,
  $user            = 'proxy',
  $group           = 'proxy',
  $purge_vhost_dir = true,
  $purge_ssl_dir   = true,
  $log_level       = 'warn',
  $vhost_template  = 'ssl_vhost.erb',
  $serveradmin     = 'ISOHelpDesk@caiso.com',
  $instance_name   = undef,
) {

  $filename = regsubst($name, ' ', '_', 'G')

  File {
    owner => $user,
    group => $group,
    mode  => '0644',
  }

  file { $ssl_dir:
    ensure => directory,
    mode   => '0750',
  }

  file { "${filename}.conf":
    ensure => file,
    path   => "${vhost_dir}/${filename}.conf",
    content => template($vhost_template),
    require => File[$ssl_dir],
  }

}
