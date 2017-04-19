define website_deploy (
  $source,
  $provider = 'git',
  $revision = 'HEAD',
  $domains  = [$name],
  $port     = false,
  $config   = $name
) {
  include supervisor
  include nginx
  case $config {
    "static": {  }
    "php":    { include apache_php }
  }

  case $provider {
    'git':   { $commit_id = generate("/bin/bash", "/root/puppet/modules/website_deploy/files/github-commit-id.sh", "$source", "/root/github/${name}", "$revision") }
    default: { $commit_id = generate("/bin/bash", "-c", "date +'%F-%H%M'") }
  }

  file { "/var/www/${name}/": ensure => directory, owner => root, group => root, mode => '0755' } ->
  exec { "${name}: remove old backups":
    command => "/bin/ls -dt */ | /usr/bin/tail -n +3 | /usr/bin/xargs --no-run-if-empty /bin/rm -rvf", # remove all but last 3 backups
    cwd     => "/var/www/${name}/",
    onlyif  => "/usr/bin/test -d /var/www/${name}/"
  } ->
  vcsrepo { "/var/www/${name}/${commit_id}/":
    ensure   => latest,
    source   => $source,
    provider => $provider
  } ->

  exec { "${name}: /root/puppet/modules/website_deploy/templates/${config}/install.sh":
    command => "/bin/bash /root/puppet/modules/website_deploy/templates/${config}/install.sh",
    cwd     => "/var/www/${name}/${commit_id}/"
  } ->
  file { "/var/www/${name}/${commit_id}/":
    ensure => "present",
    owner => root, group => root, mode => '0755'
  } ->
  file { "/var/www/${name}/current/":
    ensure => "link",
    target => "/var/www/${name}/${commit_id}",
    owner => root, group => root, mode => '0755'
  }

  case $config {
    "static": {
      file { "/etc/nginx/sites-enabled/${name}.site":
        content => template("website_deploy/${config}/nginx.site.erb"),
        # validate_cmd => "test -f /root/puppet/modules/website_deploy/templates/${name}/nginx.site.erb",
        owner   => root,
        group   => root,
        mode    => '0644',
        require => [ Package['nginx'], File['/etc/nginx/sites-enabled'] ],
        notify  => [ Service['nginx'] ]
      }
    }
    "php": {
      file { "/etc/nginx/sites-enabled/${name}.site":
        content => template("website_deploy/${config}/nginx.site.erb"),
        owner   => root,
        group   => root,
        mode    => '0644',
        require => [ Package['nginx'], File['/etc/nginx/sites-enabled'] ],
        notify  => [ Service['nginx'] ]
      }
      file { "/etc/apache2/sites-enabled/${name}.conf":
        content => template("website_deploy/${config}/apache.conf.erb"),
        owner   => root,
        group   => root,
        mode    => '0644',
        require => [ Package['apache2'] ],
        notify  => [ Service['apache2'] ]
      }
    }
    "node": {
      file { "/etc/supervisor/conf.d/${name}.conf":
        content => template("website_deploy/${config}/supervisor.conf.erb"),
        owner   => root,
        group   => root,
        mode    => '0644',
        require => [ Package['supervisor'] ],
        notify  => Service[$supervisor::supervisord],
      }
    }
  }

}
