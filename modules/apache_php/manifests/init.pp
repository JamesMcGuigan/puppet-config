class apache_php {
  # Apache 2 + PHP5
  # https://askubuntu.com/questions/756879/cant-install-php5-on-ubuntu-16-04
  #
  # sudo add-apt-repository ppa:ondrej/php
  # sudo apt-get update
  # sudo apt-get install php7.0 php5.6 php5.6-mysql php-gettext php5.6-mbstring php-xdebug libapache2-mod-php5.6 libapache2-mod-php7.0
  # from php5.6 to php7.0: sudo a2dismod php5.6 ; sudo a2enmod php7.0 ; sudo service apache2 restart
  # from php7.0 to php5.6: sudo a2dismod php7.0 ; sudo a2enmod php5.6 ; sudo service apache2 restart

  # apt::ppa { 'ppa:ondrej/php': } ->
  exec { "add-apt-repository ppa:ondrej/php":
    command => "/usr/bin/add-apt-repository ppa:ondrej/php --yes",
  } ->
  package {[
    'apache2',
    'libapache2-mod-php',
    'php',
    'php-mcrypt',
    'libapache2-mpm-itk',
    'php7.0',
    'php5.6',
    'php5.6-mysql',
    'php-gettext',
    'php5.6-mbstring',
    'php-xdebug',
    'libapache2-mod-php5.6',
    'libapache2-mod-php7.0'
  ]:
    ensure => installed
  } ->
  service { 'apache2':
    ensure => running,
    enable => true
  }

  file { '/etc/php/7.0/apache2/php.ini':
    source => 'puppet:///modules/apache_php/php/php.ini',
    owner  => 'root',
    mode   => '0644',
    notify => Service['apache2'],
  }
  file { '/etc/apache2/ports.conf':
    source => 'puppet:///modules/apache_php/ports.conf',
    owner  => 'root',
    mode   => '0644',
    notify => Service['apache2'],
  }

  file { '/etc/apache2/mods-available/php7.0.conf':
    source => 'puppet:///modules/apache_php/mods-available/php7.0.conf',
    owner  => 'root',
    mode   => '0644',
    notify => Service['apache2'],
  }

  file { '/etc/apache2/sites-enabled/000-default.conf':
    ensure => absent,
    notify => Service['apache2'],
  }

  exec { "${name}: a2dismod php7.0; a2enmod php5.6 vhost_alias":
    command => "/usr/sbin/a2dismod php7.0; /usr/sbin/a2enmod php5.6",
    notify => Service['apache2'],
  }
  exec { "${name}: a2enmod vhost_alias":
    command => "/usr/sbin/a2enmod vhost_alias",
    notify => Service['apache2'],
  }

  file { '/etc/apache2/mods-enabled/php7.0.conf':
    ensure => absent,
    target => "/etc/apache2/mods-available/php7.0.conf",
    notify => Service['apache2'],
  }
  file { '/etc/apache2/mods-enabled/php7.0.load':
    ensure => absent,
    target => "/etc/apache2/mods-available/php7.0.load",
    notify => Service['apache2'],
  }
  file { '/etc/apache2/mods-enabled/mod_mpm_prefork.so':
    ensure => absent,
    target => "/etc/apache2/mods-available/mod_mpm_prefork.so",
    notify => Service['apache2'],
  }
}
