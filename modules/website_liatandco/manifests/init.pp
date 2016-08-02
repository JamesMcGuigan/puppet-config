class website_liatandco {
  include supervisor
  include nginx

  ### Includes only work with supervisor v3 (v2 installed on CentOS)
  file { '/etc/supervisor/conf.d/liatandco.conf':
    content => template('website_liatandco/supervisor/liatandco.conf.erb'),
    owner   => root,
    group   => root,
    notify  => Service[$supervisor::supervisord],
    require => Package['supervisor']
  }

  file { '/etc/nginx/sites-enabled/liatandco.site':
    content => template('website_liatandco/nginx/liatandco.site.erb'),
    owner   => root,
    group   => root,
    mode   => '0644',
    require => [ Package['nginx'], File['/etc/nginx/sites-enabled'] ],
    notify  => [ Service['nginx'] ]
  }

  exec { 'n 0.10.39':
    command => $operatingsystem ? { CentOS => '/usr/bin/n 0.10.39', Ubuntu => '/usr/local/bin/n 0.10.39' },
  }

  file { "/var/data/":
    ensure => "directory",
    owner  => "root",
    mode   => 750,
  }

  cron { 'cron email backup /var/data/liatandco-ghost.db':
    command => "date | mailx -s 'Liatandco.com Ghost Database Backup' -a /var/data/liatandco-ghost.db -r server@liatandco.com james.mcguigan+liandandco-backup@gmail.com",
    user    => root,
    hour    => '0',
    minute  => '0',
    environment => "PATH=/bin:/usr/bin:/usr/sbin"
  }
}
