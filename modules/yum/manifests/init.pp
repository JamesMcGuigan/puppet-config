class yum {
  case $::operatingsystem {
    CentOS: {
      exec { 'epel-repo':
        command => 'rpm -Uvh http://download-i2.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm; yum update -y',
        creates => '/var/lib/yum/repos/x86_64/6/epel'
      }

      ## Don't rerun yum update every time
      package { 'yum-plugin-security':
        ensure  => installed
      }
      #package { 'yum-skip-broken':
      #  ensure  => installed
      #}

      exec { 'yum-update':
        command => 'yum clean all; yum -y --security --skip-broken update',
        timeout => 600,
        require => [ Package['yum-plugin-security'] ]
      }
    }
    Ubuntu: {}
  }
}
