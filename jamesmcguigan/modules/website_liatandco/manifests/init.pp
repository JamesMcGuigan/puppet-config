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
}
