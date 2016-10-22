class sshd {
  require bash

  $sshd = $operatingsystem ? {
    CentOS  => "sshd",
    Ubuntu  => "ssh",
  }


  package { 'openssh-server':
    ensure => 'installed',
  }
  augeas { 'ssh_config':
    context => "/files/etc/ssh/sshd_config",
    changes => [
      'set PermitRootLogin        yes', # without-password',
      'set RSAAuthentication      yes', # ssh V1
      'set PubkeyAuthentication   yes', # ssh V2
      'set PasswordAuthentication yes',
      'set AuthorizedKeysFile     %h/.ssh/authorized_keys'
    ],
    notify => Service[$sshd]
  }
  service { $sshd:
    ensure    => running,
    enable    => true,
    hasstatus => true,
    require   => Package['openssh-server']
  }
}
