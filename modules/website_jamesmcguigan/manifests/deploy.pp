class website_jamesmcguigan::deploy {
  include website_jamesmcguigan
  include supervisor

  exec { 'git pull JamesMcGuigan/jamesmcguigan.com':
    command => '/root/puppet/modules/website_jamesmcguigan/files/update-git.sh',
  } ->
  exec { 'build website_jamesmcguigan':
    command  => '/root/puppet/modules/website_jamesmcguigan/files/build-website.sh',
  } ->
  exec { 'deploy website_jamesmcguigan':
    command  => '/root/puppet/modules/website_jamesmcguigan/files/deploy-website.sh',
    notify   => Service[$supervisor::supervisord],
  }
}
