class yum {
  case $::operatingsystem {
    Ubuntu: {
        ### DOCS: https://stackoverflow.com/questions/26595620/how-to-install-ruby-2-1-4-on-ubuntu-14-04
        ### sudo apt-get install ruby2.4
        exec { 'apt-add-repository ppa:brightbox/ruby-ng':
          command => "sudo apt-add-repository ppa:brightbox/ruby-ng"
        } ->

        ### DOCS: https://stackoverflow.com/questions/10845864/run-apt-get-update-before-installing-other-packages-with-puppet
        exec { 'apt-get update':
            command => "/usr/bin/apt-get update",
            onlyif => "/bin/bash -c 'exit $(( $(( $(date +%s) - $(stat -c %Y /var/lib/apt/lists/$( ls /var/lib/apt/lists/ -tr1|tail -1 )) )) <= 604800 ))'"
        }
    }
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
