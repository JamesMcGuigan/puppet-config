# http://www.craigdunn.org/2012/05/239/
node default {
  Exec { path => '/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin', logoutput => true, }

  case $domain {
    /local/:           { $node_env = 'development' }
    /jamesmcguigan/:   { $node_env = 'production'  }
    default:           { $node_env = 'production'  }
  }
  case $::operatingsystem {
    CentOS:  { require yum }
    Ubuntu:  { }
    default: { fail("Unknown OS: $operatingsystem") }
  }

  include sshd
  include ntp
  include bash
  include build-tools
  include nodejs
  include nginx
  include sslcerts
  include rubygems
  include mongodb
}
node /jamesmcguigan/ inherits default {
  include website_jamesmcguigan
}