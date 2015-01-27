class website_statistical_learning::database {
  exec { 'curriculum-generate.js':
    command => '/usr/bin/node /root/github/statistical-learning/mongo/curriculum-generate.js',
    timeout => 1800,
  }
}