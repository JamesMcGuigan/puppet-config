username = "root";
hostname = "jamesmcguigan.com"

desc "Reboot :hostname"
task :reboot, :hostname do |t, args|
  hostname = args[:hostname];
  sh "ssh #{username}@#{hostname} 'echo; echo `hostname` is rebooting; reboot;'"
end

desc "Bootstrap Puppet onto :hostname"
task :bootstrap, :hostname do |t, args|
  hostname = args[:hostname];

  commands = <<-EOF
    ssh-keyscan -H github.com | tee -a /etc/ssh/ssh_known_hosts
    apt-get update  -y
    apt-get install -y puppet git rsync rubygems-integration
    gem install librarian-puppet
  EOF
  sh "ssh #{username}@#{hostname} '#{commands}'"
end


desc "Run Puppet :package on :hostname | rake puppet[liatandco.com,liatandco]"
task :puppet, :hostname, :package do |t, args|
    hostname = args[:hostname];
    package  = args[:package]  || "init"

    if( Rake::Task["syntax"].execute() )
        puts "Applying puppet to #{username}@#{hostname} with package manifests/#{package}.pp"

        Rake::Task["rsync_puppet"].execute(args)

        commands = <<-BOOTSTRAP
            cd /root/puppet/
            librarian-puppet install;
            puppet apply --modulepath=/root/puppet/modules/ /root/puppet/manifests/#{package}.pp --verbose --summarize --debug
        BOOTSTRAP
        sh "ssh #{username}@#{hostname} '#{commands}'"

        Rake::Task["service_restart"].execute(args)
    end
end
task :deploy, :hostname, :package do |t, args|
  args[:package] = args[:package]  || "deploy"
  Rake::Task["puppet"].execute(args)
end

desc "Rsync deploy ~/websites/:website to #{username}@:hostname:/var/www/"
task :rsync_deploy, :hostname, :website_deploy do |t, args|
    hostname = args[:hostname] || ""
    website  = args[:website_deploy]  || args[:hostname]

    sh "rsync -arz --delete --exclude 'puppet' --exclude 'data' ~/websites/#{website}      #{username}@#{hostname}:/var/www/"
    sh "rsync -arz ~/websites/#{website}/data #{username}@#{hostname}:/var/www/#{website}/"

    commands = <<-BOOTSTRAP
      cd /var/www/#{website};
      npm install;
      npm run production
    BOOTSTRAP
    sh "ssh #{username}@#{hostname} '#{commands}'"

    Rake::Task["service_restart"].execute(args)
end


task :service_restart, :hostname do |t, args|
  hostname = args[:hostname]

  commands = <<-BOOTSTRAP
    service supervisor restart
    service nginx restart
  BOOTSTRAP
  sh "ssh #{username}@#{hostname} '#{commands}'"
end

desc "rsync puppet to :hostname"
task :rsync_puppet, :hostname do |t, args|
  hostname = args[:hostname]

  sh "rsync -arz --delete --exclude '.vagrant' --exclude '.git' --exclude 'modules/vcsrepo' --exclude 'modules/stdlib' ./ #{username}@#{hostname}:puppet"
end



desc "Check Puppet and package.json syntax before deploy"
task :syntax do
    sh 'find ./ -name "*.pp" | xargs puppet parser validate'
    #sh 'find ./ -name "*.pp" -print -exec puppet-lint --no-names_containing_dash-check  --no-double_quoted_strings-check --no-arrow_alignment-check --no-documentation-check --no-variable_scope-check --no-2sp_soft_tabs-check {} \;'

    # npm install -g jsonlint
    #sh 'find ../ -depth 2 -name package.json | xargs -t -L1 jsonlint -q'
end

desc "Check code has been fully pushed to github"
task :git_check do
  if File.directory?(File.dirname(__FILE__)+'/../.git')
    # Double check that everything is pushed to git before deployment
    sh "git push --dry-run"; puts;
    sh "git status";         puts;
  end
end
