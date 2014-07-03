class nodejs {

  require build-tools

  file { ['/var/log/node']:
    ensure  => directory,
    mode    => '0700',
    owner   => 'root',
    group   => 'root'
  }


  package { 'nodejs':
    ensure  => installed
  } ->
  package { 'npm':
    ensure  => installed,
    require => Package['nodejs'],
  } ->
  exec { 'npm-registry':
    command => 'npm config set registry="http://registry.npmjs.org/"',
    require => [ Package['npm'] ]
  } ->
  exec { 'bower':
    command => 'npm install -g bower',
    creates => $operatingsystem ? { CentOS => '/usr/bin/bower', Ubuntu => '/usr/local/bin/bower' },
    require => [ Exec['npm-registry'] ]
  } ->
  exec { 'jslint':
    command => 'npm install -g jslint',
    creates => $operatingsystem ? { CentOS => '/usr/bin/jslint', Ubuntu => '/usr/local/bin/jslint' },
    require => [ Exec['npm-registry'] ]
  } ->
  file { $operatingsystem ? { CentOS => '/usr/bin/jsl', Ubuntu => '/usr/local/bin/jsl' }:
    ensure  => 'link',
    target  => $operatingsystem ? { CentOS => '/usr/bin/jslint', Ubuntu => '/usr/local/bin/jslint' },
    require => [ Exec['jslint'] ]
  }
}
