# http://www.craigdunn.org/2012/05/239/
class mongodb {
  $bind_ip = '127.0.0.1'

  $mongod = $operatingsystem ? {
    CentOS  => "mongod",
    Ubuntu  => "mongodb",
  }
  $mongoconf = $operatingsystem ? {
    CentOS  => "mongod.conf",
    Ubuntu  => "mongodb.conf",
  }
  case $::operatingsystem {
    Ubuntu: {
      package { 'mongodb':
        ensure  => installed,
      }
    }
    CentOS: {
    # http://docs.mongodb.org/manual/tutorial/install-mongodb-on-red-hat-centos-or-fedora-linux/
      file { '/etc/yum.repos.d/mongodb.repo':
        source => 'puppet:///modules/mongodb/mongodb.repo',
        owner  => 'root',
        mode   => '0644',
      }
      package { [ 'mongo-10gen', 'mongo-10gen-server']:
        ensure  => installed,
        require => File['/etc/yum.repos.d/mongodb.repo']
      }
    }
  } ->
  file { $mongoconf:
    name    => "/etc/$mongoconf",
    content => template('mongodb/mongodb.conf.erb'),
    owner   => root,
    group   => root,
    mode    => '0644',
    notify  => Service[$mongod],
  } ->
  service { $mongod:
    ensure  => running,
    enable  => true,
    require => [ File[$mongoconf] ]
  }
}
