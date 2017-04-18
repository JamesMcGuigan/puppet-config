class supervisor {
  $supervisord = $operatingsystem ? {
    CentOS  => "supervisord",
    Ubuntu  => "supervisor",
  }

  package { 'supervisor':
    ensure  => installed,
    require => File['/etc/supervisor/conf.d']
  }

  service { $supervisord:
    ensure  => running,
    enable  => true,
    require => Package['supervisor']
  }

  file { ['/etc/supervisor','/etc/supervisor/conf.d']:
    ensure  => directory,
    mode    => '0755',
    owner   => 'root',
    group   => 'root'
  } ->

  # Supervisord restart doesn't reload the configuration - service reload will
  # However puppet notify calls service stop && service start - which will reload the config
  file { '/etc/supervisord.conf':
    name    => '/etc/supervisord.conf',
    source => 'puppet:///modules/supervisor/supervisord.conf',
    owner   => root,
    group   => root,
    mode    => '0644',
    require => Package['supervisor'],
    notify  => Service[$supervisord]
  }
}
