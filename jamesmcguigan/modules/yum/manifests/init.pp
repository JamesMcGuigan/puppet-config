class yum {
  case $::operatingsystem {
    CentOS: {
      exec { 'epel-repo':
        command => 'rpm -Uvh http://download-i2.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm',
        creates => '/var/lib/yum/repos/x86_64/6/epel'
      }
      exec { 'yum-update':
        command => 'yum update -y',
        timeout => 1800
      }
    }
    Ubuntu: {}
  }
}
