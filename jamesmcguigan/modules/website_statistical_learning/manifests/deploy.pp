class website_statistical_learning::deploy {
  include website_statistical_learning
  include supervisor

  exec { 'git pull JamesMcGuigan/statistical-learning':
    command => '/root/puppet/modules/website_statistical_learning/files/update-git.sh',
  } ->
  exec { 'build website_statistical_learning':
    command  => '/root/puppet/modules/website_statistical_learning/files/build-website.sh',
  } ->
  exec { 'deploy website_statistical_learning':
    command  => '/root/puppet/modules/website_statistical_learning/files/deploy-website.sh',
    notify   => Service[$supervisor::supervisord],
  }
}