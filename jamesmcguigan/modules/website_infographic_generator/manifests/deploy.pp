class website_infographic_generator::deploy {
  include website_infographic_generator
  include supervisor

  exec { 'git pull JamesMcGuigan/infographic-generator':
    command => '/root/puppet/modules/website_infographic_generator/files/update-git.sh',
  } ->
  exec { 'build website_infographic_generator':
    command  => '/root/puppet/modules/website_infographic_generator/files/build-website.sh',
  } ->
  exec { 'deploy website_infographic_generator':
    command  => '/root/puppet/modules/website_infographic_generator/files/deploy-website.sh',
    notify   => Service[$supervisor::supervisord],
  }
}