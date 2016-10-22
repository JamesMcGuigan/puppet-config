class website_jamesmcguigan {
  include supervisor
  include nginx

  file { '/etc/nginx/sites-enabled/jamesmcguigan.site':
    content => template('website_jamesmcguigan/nginx/jamesmcguigan.site.erb'),
    owner   => root,
    group   => root,
    mode   => '0644',
    require => [ Package['nginx'], File['/etc/nginx/sites-enabled'] ],
    notify  => [ Service['nginx'] ]
  }
}
