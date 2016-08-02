class website_statistical_learning {
  include mongodb
  include supervisor
  include nginx

  ### Download from github and install SSL certs before NGINX config
  file {[
    '/root/puppet/modules/website_statistical_learning/files/update-git.sh',
    '/root/puppet/modules/website_statistical_learning/files/build-website.sh',
    '/root/puppet/modules/website_statistical_learning/files/deploy-website.sh'
  ]:
    ensure => file,
    mode   => '0755',
    owner  => 'root',
  }
  file {[ '/root/github/statistical-learning/sslcert/san/generate-san.sh',]:
    ensure  => file,
    mode    => '0755',
    owner   => 'root',
    require => Exec['init: /root/puppet/modules/website_statistical_learning/files/update-git.sh']
  }


  exec { 'init: /root/puppet/modules/website_statistical_learning/files/update-git.sh':
    command =>      '/root/puppet/modules/website_statistical_learning/files/update-git.sh',
    require => File['/root/puppet/modules/website_statistical_learning/files/update-git.sh']
  } ->

  exec { '/root/github/statistical-learning/sslcert/san/generate-san.sh':
    command =>      '/root/github/statistical-learning/sslcert/san/generate-san.sh',
    require => File['/root/github/statistical-learning/sslcert/san/generate-san.sh'],
    creates =>      '/root/github/statistical-learning/sslcert/san/statistical-learning.san.crt',
  } ->

  file { '/var/sslcerts/statistical-learning.san.crt':
    source => '/root/github/statistical-learning/sslcert/san/statistical-learning.san.crt',
    owner  => 'root',
    mode   => '0644',
  } ->
  file { '/var/sslcerts/statistical-learning.san.key':
    source => '/root/github/statistical-learning/sslcert/san/statistical-learning.san.key',
    owner  => 'root',
    mode   => '0644',
  } ->


  ### Includes only work with supervisor v3 (v2 installed on CentOS)
  file { '/etc/supervisor/conf.d/statistical-learning.conf':
    content => template('website_statistical_learning/supervisor/statistical-learning.conf.erb'),
    owner   => root,
    group   => root,
    notify  => Service[$supervisor::supervisord],
    require => Package['supervisor']
  } ->

  file { '/etc/nginx/sites-enabled/statistical-learning.site':
    content => template('website_statistical_learning/nginx/statistical-learning.site.erb'),
    owner   => root,
    group   => root,
    mode   => '0644',
    require => [ Package['nginx'], File['/etc/nginx/sites-enabled'] ],
    notify  => [ Service['nginx'] ]
  }
}
