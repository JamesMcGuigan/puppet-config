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
node /jamesmcguigan/ {
  include nginx
}
node /liatandco/ {
  include nginx
}
