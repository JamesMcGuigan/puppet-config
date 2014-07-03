class website_jamesmcguigan {
  include supervisor
  include nginx

  ### Includes only work with supervisor v3 (v2 installed on CentOS)
  file { '/etc/supervisor/conf.d/jamesmcguigan.conf':
    content => template('website_jamesmcguigan/supervisor/jamesmcguigan.conf.erb'),
    owner   => root,
    group   => root,
    notify  => Service[$supervisor::supervisord],
    require => Package['supervisor']
  }

  file { '/etc/nginx/sites-enabled/jamesmcguigan.site':
    content => template('website_jamesmcguigan/nginx/jamesmcguigan.site.erb'),
    owner   => root,
    group   => root,
    mode   => '0644',
    require => [ Package['nginx'], File['/etc/nginx/sites-enabled'] ],
    notify  => [ Service['nginx'] ]
  }
}
