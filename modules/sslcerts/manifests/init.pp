class sslcerts {
#  exec { 'Generate SSL Keys':
#    command => '/root/puppet/modules/sslcerts/files/generate-san.sh',
#    creates => '/root/puppet/modules/sslcerts/files/jamesmcguigan.key'
#  } ->
  file { '/var/sslcerts/':
    source  => 'puppet:///modules/sslcerts/',
    owner   => 'root',
    mode    => '0700',
    recurse => true
  }
}
