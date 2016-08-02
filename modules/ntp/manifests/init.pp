class ntp {
  $ntpd = $operatingsystem ? {
    CentOS  => "ntpd",
    Ubuntu  => "ntp",
  }

  package { 'ntp':
    ensure  => installed
  }
  service { $ntpd:
    ensure  => 'running',
    require => Package['ntp'],
    enable  => true
  }
  exec { 'timezone-UTC':
    command => 'ln -sf /usr/share/zoneinfo/UTC /etc/localtime',
  }
  exec { 'hwclock':
    command => 'hwclock --systohc && ( sleep 1m && hwclock --systohc) &',  # wait for ntpd
    require => [ Package['ntp'], Exec['timezone-UTC'] ]
  }
}