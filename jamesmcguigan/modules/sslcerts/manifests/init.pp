class sslcerts {
  file { ['/var/sslcerts']:
    ensure  => directory,
    mode    => '0700',
    owner   => 'root',
    group   => 'root'
  }
  exec { 'Generate SSL Keys':
    command => '/root/puppet/modules/sslcerts/files/generate-san.sh',
    creates => '/root/puppet/modules/sslcerts/files/jamesmcguigan.key'
  } ->
  file { '/var/sslcerts/jamesmcguigan.san.crt':
    source  => 'puppet:///modules/sslcerts/jamesmcguigan.san.crt',
    owner   => 'root',
    mode    => '0600',
    require => File['/var/sslcerts']
  } ->
  file { '/var/sslcerts/jamesmcguigan.san.key':
    source  => 'puppet:///modules/sslcerts/jamesmcguigan.san.key',
    owner   => 'root',
    mode    => '0600',
    require => File['/var/sslcerts']
  }
}
