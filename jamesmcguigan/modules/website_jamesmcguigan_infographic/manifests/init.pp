class website_jamesmcguigan_infographic {
  include supervisor
  include nginx

  ### Includes only work with supervisor v3 (v2 installed on CentOS)
  file { '/etc/supervisor/conf.d/infographic.jamesmcguigan.conf':
    content => template('website_jamesmcguigan_infographic/supervisor/infographic.jamesmcguigan.conf.erb'),
    owner   => root,
    group   => root,
    notify  => Service[$supervisor::supervisord],
    require => Package['supervisor']
  }

  file { '/etc/nginx/sites-enabled/infographic.jamesmcguigan.site':
    content => template('website_jamesmcguigan_infographic/nginx/infographic.jamesmcguigan.site.erb'),
    owner   => root,
    group   => root,
    mode   => '0644',
    require => [ Package['nginx'], File['/etc/nginx/sites-enabled'] ],
    notify  => [ Service['nginx'] ]
  }
}