class nodejs {

  require build_tools

  file { ['/var/log/node']:
    ensure  => directory,
    mode    => '0700',
    owner   => 'root',
    group   => 'root'
  }


  package { 'nodejs':
    ensure  => latest
  } ->
  file { "/usr/bin/node":
    ensure => link,
    target => "/usr/bin/nodejs",
  } ->
  ### n installs to /usr/local/n/versions/node/10.1.0/bin/node -> /usr/local/bin/node
  exec { 'n':
    command => 'npm install -g n',
    creates => $operatingsystem ? { CentOS => '/usr/bin/n', Ubuntu => '/usr/local/bin/n' },
  } ->
  exec { 'n latest':
    command => 'n latest; n latest',  # $? returns invalid error code if version of node has changed
  } ->
  ### liatandco.com requires Ghost ^0.6.4 -> requires node 0.10.39 -> does not support yarn
  # exec { 'yarn':
  #   command => 'npm install -g yarn',
  # } ->
  exec { 'npm':
    command => 'npm install -g npm',
  } ->
  exec { 'npm-registry':
    command => 'npm config set registry="http://registry.npmjs.org/"',
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
  exec { 'browserify':
    command => 'npm install -g browserify',
    creates => $operatingsystem ? { CentOS => '/usr/bin/browserify', Ubuntu => '/usr/local/bin/browserify' },
    require => [ Exec['npm-registry'] ]
  } ->
  exec { 'uglifyjs':
    command => 'npm install -g uglifyjs',
    creates => $operatingsystem ? { CentOS => '/usr/bin/uglifyjs', Ubuntu => '/usr/local/bin/uglifyjs' },
    require => [ Exec['npm-registry'] ]
  } ->
  exec { 'webpack':
    command => 'npm install -g webpack',
    creates => $operatingsystem ? { CentOS => '/usr/bin/webpack', Ubuntu => '/usr/local/bin/webpack' },
    require => [ Exec['npm-registry'] ]
  } ->
  file { $operatingsystem ? { CentOS => '/usr/bin/jsl', Ubuntu => '/usr/local/bin/jsl' }:
    ensure  => 'link',
    target  => $operatingsystem ? { CentOS => '/usr/bin/jslint', Ubuntu => '/usr/local/bin/jslint' },
    require => [ Exec['jslint'] ]
  }
}
