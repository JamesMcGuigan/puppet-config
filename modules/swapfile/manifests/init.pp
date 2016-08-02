class swapfile {
  file {[ '/root/puppet/modules/swapfile/files/create-swapfile.sh',]:
    ensure  => file,
    mode    => '0755',
    owner   => 'root',
  }
  exec { '/root/puppet/modules/swapfile/files/create-swapfile.sh':
    command =>      '/root/puppet/modules/swapfile/files/create-swapfile.sh',
    require => File['/root/puppet/modules/swapfile/files/create-swapfile.sh']
  }
}
