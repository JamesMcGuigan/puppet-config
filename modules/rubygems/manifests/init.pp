class rubygems {
  require build_tools

  case $::operatingsystem {
    Ubuntu: {}
    CentOS: {
      package { ['rubygems','ruby-devel']:
        ensure  => installed,
        require => Package['ruby']
      }
      exec { 'gem-update':
        command => 'gem update --system',
        creates => '/usr/bin/rake',        # only run this on first deploy - shows as red in deploy script
        require => [ Package['ruby'] ]
      }
    }
  }

  package { 'ruby':
    ensure  => installed,
  } ->
  exec { 'rake':
    command => 'gem install rake',
    creates => $operatingsystem ? { CentOS => '/usr/bin/rake', Ubuntu => '/usr/local/bin/rake' },
  } ->
  exec { 'compass susy':
    command => 'gem install compass susy',
    creates => $operatingsystem ? { CentOS => '/usr/bin/compass', Ubuntu => '/usr/local/bin/compass' },
    require => [ Exec['rake'] ]
  }

  package { 'bundler':
    ensure  => installed,
  }
}
