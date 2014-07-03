class puppet {
  service { "puppet":
    ensure     => stopped,
    enable     => false,
    subscribe  => File["/etc/puppet/puppet.conf"],
    hasrestart => true,
    hasstatus  => true,
  }
}