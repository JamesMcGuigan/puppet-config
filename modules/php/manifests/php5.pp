class php::php5 inherits php {
  include supervisor

  exec { '/usr/bin/wget http://uk1.php.net/distributions/php-5.6.30.tar.bz2 -O php-5.6.30.tar.bz2':
    cwd    => '/usr/local/src',
    onlyif => "/usr/bin/test ! -f /usr/local/src/php-5.6.30.tar.bz2"
  } ->
  exec { '/bin/tar -xjf php-5.6.30.tar.bz2':
    cwd    => '/usr/local/src',
    onlyif => "/usr/bin/test ! -d /usr/local/src/php-5.6.30/"
  } ->

  exec { '/usr/local/src/php-5.6.30/configure --prefix=/usr/local/php5 --exec-prefix=/usr/local/php5 --program-suffix=5 --enable-fpm':
    cwd    => '/usr/local/src/php-5.6.30/',
    onlyif => "/usr/bin/test ! -d /usr/local/php5"
  } ->
  exec { 'php5 /usr/bin/make':
    command => '/usr/bin/make',
    cwd     => '/usr/local/src/php-5.6.30/',
    onlyif  => "/usr/bin/test ! -d /usr/local/php5"
  } ->
  exec { 'php5 /usr/bin/make install':
    command => '/usr/bin/make install',
    cwd     => '/usr/local/src/php-5.6.30/',
    onlyif  => "/usr/bin/test ! -d /usr/local/php5"
  } ->

  file { '/usr/local/php5/etc/php-fpm.conf':
    source => 'puppet:///modules/php/php-fpm.conf',
    owner  => 'root',
    mode   => '0644',
  } ->

  file { '/etc/supervisor/conf.d/php5-fpm.conf':
    source => 'puppet:///modules/php/supervisor/php5-fpm.supervisor.conf',
    owner   => root,
    group   => root,
    notify  => Service[$supervisor::supervisord],
    require => Package['supervisor']
  }
}
