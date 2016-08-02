class bash {
  package { 'bash':            ensure  => installed }
  package { 'bash-completion': ensure  => installed }
  package { 'curl':            ensure  => installed }
  package { 'fortune-mod':     ensure  => installed }
  package { 'git':             ensure  => installed }
#  package { 'jsl':             ensure  => installed }
  package { 'man':             ensure  => installed }
  package { 'moreutils':       ensure  => installed }
  package { 'nmap':            ensure  => installed }
  package { 'screen':          ensure  => installed }
  package { 'wget':            ensure  => installed }
  package { 'ImageMagick':     ensure  => installed }
  package { 'GraphicsMagick':  ensure  => installed }



  case $::operatingsystem {
    Ubuntu: {
      package { 'vim':             ensure  => installed }
      package { 'bind9utils':      ensure  => installed }
    }
    CentOS: {
      require yum
      package { 'augeas':          ensure  => installed }
      package { 'vim-common':      ensure  => installed }
      package { 'vim-enhanced':    ensure  => installed }
      package { 'vim-minimal':     ensure  => installed }
      package { 'bind-utils':      ensure  => installed }
    }
  }


  file { '/root/.bashrc_alias':
    source => 'puppet:///modules/bash/.bashrc_alias',
    owner  => 'root',
    mode   => '0644',
  }
  file { '/root/.bashrc_config':
    source => 'puppet:///modules/bash/.bashrc_config',
    owner  => 'root',
    mode   => '0644',
  }
  file { '/root/.bashrc_functions':
    source => 'puppet:///modules/bash/.bashrc_functions',
    owner  => 'root',
    mode   => '0644',
  }
  file { '/root/.bashrc_prompt':
    source => 'puppet:///modules/bash/.bashrc_prompt',
    owner  => 'root',
    mode   => '0644',
  }
  file { '/root/.bashrc':
    source => 'puppet:///modules/bash/.bashrc',
    owner  => 'root',
    mode   => '0644',
  }
  file { '/root/.screenrc':
    source => 'puppet:///modules/bash/.screenrc',
    owner  => 'root',
    mode   => '0644'
  }
  file { '/root/.vimrc':
    source => 'puppet:///modules/bash/.vimrc',
    owner  => 'root',
    mode   => '0644'
  }
  file { '/root/.gitconfig':
    source => 'puppet:///modules/bash/.gitconfig',
    owner  => 'root',
    mode   => '0644',
  }
}
