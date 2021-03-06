# http://www.craigdunn.org/2012/05/239/
class role {}
class role::server {
  Exec { path => '/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin', logoutput => true, }

  case $domain {
    /local/:         { $node_env = 'development' }
    /jamesmcguigan/: { $node_env = 'production' }
    default:         { $node_env = 'production' }
  }
  case $::operatingsystem {
    CentOS:  { require yum }
    Ubuntu:  { require yum }
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
  include role::server::webserver
  include mongodb
  #include php::php4
  include php::php5
  include apache_php
  include website_deploy::all
}
node /liatandco/ {
  include role::server::webserver # Ghost ^0.6.4 requires node 0.10.39 - does not support yarn
  include mailx
  include website_liatandco
  include website_liatandco::deploy
}
