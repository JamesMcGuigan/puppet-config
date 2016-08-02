class website_infographic_generator {
  include mongodb
  include supervisor
  include nginx

  ### Download from github and install SSL certs before NGINX config
  file {[
    '/root/puppet/modules/website_infographic_generator/files/update-git.sh',
    '/root/puppet/modules/website_infographic_generator/files/build-website.sh',
    '/root/puppet/modules/website_infographic_generator/files/deploy-website.sh'
  ]:
    ensure => file,
    mode   => '0755',
    owner  => 'root',
  }
  file {[ '/root/github/infographic-generator/sslcert/san/generate-san.sh',]:
    ensure  => file,
    mode    => '0755',
    owner   => 'root',
    require => Exec['init: /root/puppet/modules/website_infographic_generator/files/update-git.sh']
  }


  exec { 'init: /root/puppet/modules/website_infographic_generator/files/update-git.sh':
    command =>      '/root/puppet/modules/website_infographic_generator/files/update-git.sh',
    require => File['/root/puppet/modules/website_infographic_generator/files/update-git.sh']
  } ->

  exec { '/root/github/infographic-generator/sslcert/san/generate-san.sh':
    command =>      '/root/github/infographic-generator/sslcert/san/generate-san.sh',
    require => File['/root/github/infographic-generator/sslcert/san/generate-san.sh'],
    creates =>      '/root/github/infographic-generator/sslcert/san/infographic-generator.san.crt',
  } ->

  file { '/var/sslcerts/infographic-generator.san.crt':
    source => '/root/github/infographic-generator/sslcert/san/infographic-generator.san.crt',
    owner  => 'root',
    mode   => '0644',
  } ->
  file { '/var/sslcerts/infographic-generator.san.key':
    source => '/root/github/infographic-generator/sslcert/san/infographic-generator.san.key',
    owner  => 'root',
    mode   => '0644',
  } ->


  ### Includes only work with supervisor v3 (v2 installed on CentOS)
  file { '/etc/supervisor/conf.d/infographic-generator.conf':
    content => template('website_infographic_generator/supervisor/infographic-generator.conf.erb'),
    owner   => root,
    group   => root,
    notify  => Service[$supervisor::supervisord],
    require => Package['supervisor']
  } ->

  file { '/etc/nginx/sites-enabled/infographic-generator.site':
    content => template('website_infographic_generator/nginx/infographic-generator.site.erb'),
    owner   => root,
    group   => root,
    mode   => '0644',
    require => [ Package['nginx'], File['/etc/nginx/sites-enabled'] ],
    notify  => [ Service['nginx'] ]
  }
}
