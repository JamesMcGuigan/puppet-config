class php::php4 inherits php {

  exec { '/usr/bin/wget http://uk.php.net/distributions/php-4.4.9.tar.gz -O php-4.4.9.tar.gz':
    cwd    => '/usr/local/src',
    onlyif => "/usr/bin/test ! -f /usr/local/src/php-4.4.9.tar.gz"
  } ->
  exec { '/bin/tar -xzf php-4.4.9.tar.gz':
    cwd    => '/usr/local/src',
    onlyif => "/usr/bin/test ! -d /usr/local/src/php-4.4.9/"
  } ->
  exec { '/usr/local/src/php-4.4.9/configure --prefix=/usr/local/php4 --exec-prefix=/usr/local/php4 --program-suffix=4':
    cwd    => '/usr/local/src/php-4.4.9/',
    onlyif => "/usr/bin/test ! -d /usr/local/php4"
  } ->
  exec { 'php4 /usr/bin/make':
    command => '/usr/bin/make',
    cwd     => '/usr/local/src/php-4.4.9/',
    onlyif  => "/usr/bin/test ! -d /usr/local/php4"
  } ->
  exec { 'php4 /usr/bin/make install':
    command => '/usr/bin/make install',
    cwd     => '/usr/local/src/php-4.4.9/',
    onlyif  => "/usr/bin/test ! -d /usr/local/php4"
  }
}
