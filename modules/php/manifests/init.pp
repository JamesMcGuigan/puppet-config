class php {
  package { ['byacc', 'flex', 'libxml2-dev']:
    ensure => installed
  } ->
  file { '/usr/local/src': ensure => directory }

  group { 'nobody':
    ensure => 'present'
  } ->
  user { 'nobody':
    ensure           => 'present',
    gid              => 'nobody',
    password         => '!!',
    password_max_age => '99999',
    password_min_age => '0',
    shell            => '/bin/bash',
  }
}
