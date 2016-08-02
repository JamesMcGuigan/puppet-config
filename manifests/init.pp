# http://www.craigdunn.org/2012/05/239/
class role::server {
  Exec { path => '/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin', logoutput => true, }

  case $domain {
    /local/:         { $node_env = 'development' }
    /jamesmcguigan/: { $node_env = 'production' }
    default:         { $node_env = 'production' }
  }
  case $::operatingsystem {
    CentOS:  { require yum }
    Ubuntu:  { }
    default: { fail("Unknown OS: $operatingsystem") }
  }
}
class role::server::webserver inherits role::server {
  include swapfile
  include sshd
  include ntp
  include bash
  include build_tools
  include nodejs
  include nginx
  include sslcerts
  include rubygems
}
node /jamesmcguigan/ {
  include mongodb
  include role::server::webserver
  include website_jamesmcguigan
  include website_statistical_learning
  include website_infographic_generator
}
node /liatandco/ {
  include mailx
  include role::server::webserver
  include website_liatandco
}
