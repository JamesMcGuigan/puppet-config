class website_liatandco::deploy {
  include website_liatandco

  file {[
    '/root/puppet/modules/website_liatandco/files/update-git.sh',
    '/root/puppet/modules/website_liatandco/files/build-website.sh',
    '/root/puppet/modules/website_liatandco/files/deploy-website.sh'
  ]:
    ensure => file,
    mode   => '0755',
    owner  => 'root',
  }

  exec { 'git pull JamesMcGuigan/liatandco.com':
    command => '/root/puppet/modules/website_liatandco/files/update-git.sh',
  } ->
  exec { 'build website_liatandco':
    command  => '/root/puppet/modules/website_liatandco/files/build-website.sh',
  } ->
  exec { 'deploy website_liatandco':
    command  => '/root/puppet/modules/website_liatandco/files/deploy-website.sh',
  }
}