class build-tools {
  case $::operatingsystem {
    Ubuntu: {
      package { 'linux-headers-generic': ensure  => installed }
      package { 'build-essential':       ensure  => installed }
    }
    CentoOS: {
      package { 'readline-devel': ensure  => installed } ->
      package { 'ncurses-devel':  ensure  => installed } ->
      package { 'libffi-devel':   ensure  => installed } ->
      package { 'libyaml-devel':  ensure  => installed } ->
      exec    { 'development-tools':
        command => 'yum groupinstall -y "Development Tools"',
        timeout => 1800
      }
    }
  }
}
