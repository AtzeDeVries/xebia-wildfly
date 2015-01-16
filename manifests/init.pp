#== Class: wildfly
class wildfly(
  $bind_address               = $wildfly::params::bind_address,
  $bind_address_management    = $wildfly::params::bind_address_management,
  $user                       = $wildfly::params::user,
  $shell                      = $wildfly::params::shell,
  $install_dir                = $wildfly::params::install_dir,
  $install_java               = $wildfly::params::install_java,
  $version                    = $wildfly::params::version,
  $mode                       = $wildfly::params::mode,
  $profile                    = $wildfly::params::profile,
  $wait_time                  = $wildfly::params::wait_time,
  $console_log                = $wildfly::params::console_log,
  $pid_file                   = $wildfly::params::pid_file,
  $proxy_url                  = $wildfly::params::proxy_url,
  $deployment_dir             = $wildfly::params::deployment_dir,
  $admin_user                 = $wildfly::params::admin_user,
  $admin_password             = $wildfly::params::admin_password,
  $ajp_port                   = $wildfly::params::ajp_port,
  $http_port                  = $wildfly::params::http_port,
  $https_port                 = $wildfly::params::https_port,
  $management_http_port       = $wildfly::params::management_http_port,
  $management_https_port      = $wildfly::params::management_https_port,
  $postgresql_version         = $wildfly::params::postgresql_version,
  $install_postgresql_driver  = $wildfly::params::install_postgresql_driver,
  $install_mq_driver          = $wildfly::params::install_mq_driver,
  $xmx                        = $wildfly::params::xmx,
  $xms                        = $wildfly::params::xms,
  $maxpermsize                = $wildfly::params::maxpermsize,
  $logging_properties         = $wildfly::params::logging_properties,
  $system_properties          = $wildfly::params::system_properties,
  $debug_mode                 = $wildfly::params::debug_mode
) inherits wildfly::params {

  include wildfly::validation




  #flow
  anchor{'wildfly::begin':}
  -> class{'wildfly::install':}
  ~> class{'wildfly::config':}
  ~> class{'wildfly::config::profile':}
  ~> class{'wildfly::config::logging':}
  ~> class{'wildfly::drivers':}
  ~> class{'wildfly::service':}
  -> anchor{'wildfly::end': }

}
