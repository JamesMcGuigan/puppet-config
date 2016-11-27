class sslcerts {
  exec { 'Generate SSL Keys':
    command => '/root/puppet/modules/sslcerts/scripts/generate-san.sh',
    creates => '/root/puppet/modules/sslcerts/scripts/jamesmcguigan.san.key'
  } ->
  file { '/var/sslcerts/':
    source  => '/root/puppet/modules/sslcerts/scripts/',
    owner   => 'root',
    mode    => '0700',
    recurse => true
  }
}
