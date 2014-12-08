class website_oliverjameshymans_proxy {
#  include supervisor
  include nginx

#  ### Includes only work with supervisor v3 (v2 installed on CentOS)
#  file { '/etc/supervisor/conf.d/oliverjameshymans-proxy.conf':
#    content => template('website_oliverjameshymans_proxy/supervisor/oliverjameshymans-proxy.conf.erb'),
#    owner   => root,
#    group   => root,
#    notify  => Service[$supervisor::supervisord],
#    require => Package['supervisor']
#  }

  file { '/etc/nginx/sites-enabled/oliverjameshymans-proxy.site':
    content => template('website_oliverjameshymans_proxy/nginx/oliverjameshymans-proxy.site.erb'),
    owner   => root,
    group   => root,
    mode   => '0644',
    require => [ Package['nginx'], File['/etc/nginx/sites-enabled'] ],
    notify  => [ Service['nginx'] ]
  }
}
