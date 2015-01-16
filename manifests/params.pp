# == Class wildfly::params
#
# This class is meant to be called from wildfly
# It sets variables according to platform
#
class wildfly::params {
  $bind_address             = '0.0.0.0'
  $bind_address_management  = '0.0.0.0'
  $user = 'wildfly'
  $shell = '/bin/bash'
  $install_dir = '/opt'
  $version = '8.1.0.Final'
  $mode = 'standalone'
  $profile = 'standalone-full'
  $wait_time = '60'
  $console_log = '/var/log/wildfly/console.log'
  $pid_file = '/var/run/wildfly/wildfly.pid'
  $proxy_url = undef
  $install_java = true
  $deployment_dir = '/var/tmp'

  # admin user
  $admin_user = 'wildfly-admin'
  $admin_password = 'changeme'

  #port config
  $ajp_port                 = '8009'
  $http_port                = '8080'
  $https_port               = '8443'
  $management_http_port     = '9990'
  $management_https_port    = '9993'

  #driver config
  $install_postgresql_driver = false
  $postgresql_version        = '9.2-1004'
  $install_mq_driver         = false

  #memory settings
  $xms                      = '256m'
  $xmx                      = '512m'
  $maxpermsize              = '128m'

  #logging settings
  $logging_properties       = {}

  $system_properties        = {}

  #debug_mode
  $debug_mode               = false

  case $::osfamily {
    'RedHat': {
      $default_conf = '/etc/default/wildfly.conf'
      $init_script = 'wildfly-init-redhat.sh'
    }
    'Debian': {
      $default_conf = '/etc/default/wildfly'
      $init_script = 'wildfly-init-debian.sh'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }

}
