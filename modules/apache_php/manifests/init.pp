class apache_php {
  package { ['apache2', 'libapache2-mod-php', 'php', 'php-mcrypt', 'libapache2-mpm-itk']:
    ensure => installed
  }

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

  file { '/etc/apache2/mods-enabled/php7.0.conf':
    ensure => link,
    target => "/etc/apache2/mods-available/php7.0.conf",
    notify => Service['apache2'],
  }
  file { '/etc/apache2/mods-enabled/php7.0.load':
    ensure => absent,
    target => "/etc/apache2/mods-available/php7.0.load",
    notify => Service['apache2'],
  }
  file { '/etc/apache2/mods-enabled/mod_mpm_prefork.so':
    ensure => link,
    target => "/etc/apache2/mods-available/mod_mpm_prefork.so",
    notify => Service['apache2'],
  }


}
