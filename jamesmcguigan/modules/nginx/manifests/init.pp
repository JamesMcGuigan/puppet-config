### See website_* packages for individual config files

class nginx {
  require sslcerts

  group { "nginx":
    ensure => present
  }
  user { "nginx":
    ensure     => present,
    gid        => "nginx",
    groups     => ["nginx"],
    membership => minimum,
    shell      => "/bin/bash",
    require    => Group["nginx"]
  }

  package { 'nginx':
    ensure => installed,
  }

  service { 'nginx':
    ensure  => 'running',
    enable  => true,
#    ensure  => 'stopped',
#    enable  => false,
    require => [ Package['nginx'] ]
  }

  file { '/etc/nginx/mime.types':
    source  => 'puppet:///modules/nginx/mime.types',
    owner   => root,
    group   => root,
    mode   => '0600',
    require => Package['nginx'],
  }

  file {[
    '/etc/nginx/conf.d',
    '/etc/nginx/sites-enabled'
  ]:
    ensure  => directory,
    owner   => root,
    group   => root,
    mode    => '0700',
    require => Package['nginx']
  }
  file {[
    '/var/log/nginx'
  ]:
    ensure  => directory,
    owner   => nginx,
    group   => nginx,
    mode    => '0700',
    require => Package['nginx']
  }

  file {[
    '/etc/nginx/conf.d/default.conf',
    '/etc/nginx/conf.d/ssl.conf',
    '/etc/nginx/conf.d/virtual.conf',
    '/etc/nginx/sites-enabled/default'
  ]:
    ensure  => absent,
    require => Package['nginx'],
    notify  => Service['nginx'],
  }

  file { '/etc/nginx/nginx.conf':
    source  => 'puppet:///modules/nginx/nginx.conf',
    owner   => root,
    group   => root,
    mode   => '0600',
    require => [ Package['nginx'] ],
    notify  => [ Service['nginx'] ]
  }

  file { '/etc/nginx/conf/':
    source  => 'puppet:///modules/nginx/conf',
    recurse => true,
    owner   => root,
    group   => root,
    mode    => '0644',
    require => [ Package['nginx'] ],
    notify  => [ Service['nginx'] ]
  }
}
