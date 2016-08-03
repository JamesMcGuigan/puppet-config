# Installation

```sh
sudo gem install puppet
sudo gem install puppet-lint
```

# [Rakefile](Rakefile)
```
desc "Run Puppet :package on :hostname | rake puppet[liatandco.com,liatandco]"
task :puppet, :hostname, :package do |t, args|
```


## [liatandco.com](http://www.liatandco.com)

```sh
rake puppet[liatandco.com,liatandco]
```
```
Applying puppet to root@liatandco.com with package manifests/liatandco.pp
rsync -arz --delete --exclude '.vagrant' ./ root@liatandco.com:puppet
ssh root@liatandco.com 'puppet apply --modulepath=/root/puppet/modules/ /root/puppet/manifests/liatandco.pp --verbose --summarize --debug'
```




## [jamesmcguigan.com](http://www.jamesmcguigan.com)

```sh
rake bootstrap[jamesmcguigan.com]                    # install puppet and basic tools before first run 
rake puppet[jamesmcguigan.com,init]                  # update server and deploy
rake puppet[jamesmcguigan.com,deploy]                # just update website content
rake puppet[jamesmcguigan.com,jamesmcguigan]         # single website
rake puppet[jamesmcguigan.com,infographic-generator] # single website
rake puppet[jamesmcguigan.com,statistical-learning]  # single website
```
```
Applying puppet to root@jamesmcguigan.com with package manifests/init.pp
rsync -arz --delete --exclude '.vagrant' ./ root@jamesmcguigan.com:puppet
ssh root@jamesmcguigan.com 'puppet apply --modulepath=/root/puppet/modules/ /root/puppet/manifests/init.pp --verbose --summarize --debug'
```


# Manifests

[manifests/init.pp](manifests/init.pp)
```puppet
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
```

[manifests/deploy.pp](manifests/deploy.pp)
```puppet
node /jamesmcguigan/ {
  include website_infographic_generator::deploy
  include website_statistical_learning::deploy
}
node /liatandco/ {
  include website_liatandco::deploy
}
```

[manifests/liatandco.pp](manifests/liatandco.pp)
```puppet
node /jamesmcguigan/ {
  include website_liatandco
  include website_liatandco::deploy
}
node /liatandco/ {
  include website_liatandco
  include website_liatandco::deploy
}
```
