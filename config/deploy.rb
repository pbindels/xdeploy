require 'bundler/capistrano'
require 'sidekiq/capistrano'

load 'deploy/assets'

set :bundle_without, [:darwin, :development, :test]

set :environment, 'production'
set :application, "qdeploy"
set :repository,  "git@github.com:okl/qdeploy.git"
set :user, 'oklrelease'
set :scm, :git
set :branch, "master"
set :deploy_via, :remote_cache
set :use_sudo, false
set :deploy_to,   "/okl/qdeploy/rails"
#set :ruby_home,   "/opt/ruby/1.9.3-p484"
set :ruby_home,   "/opt/ruby/1.9.3-p392"
set :node_home,   "/opt/node/0.6.10"
set :mysql_home,  "/opt/mysql/5.1.53"
set :ruby,        "#{ruby_home}/bin/ruby"
set :bundle_bin,  "#{ruby_home}/bin/bundle"
set :rake,        "#{bundle_bin} exec rake"

set :default_shell, '/bin/bash'

set :default_environment, { 
  :PATH             => "#{ruby_home}/bin:#{node_home}/bin:#{mysql_home}/bin:/usr/local/bin:/opt/local/bin:/bin:/usr/bin",
  :LD_LIBRARY_PATH => "#{mysql_home}/lib"
}

set :ssh_options, {:forward_agent => true, :keys => [File.join(ENV["HOME"], ".ssh", "id_rsa")] }

# sidekiq
set :sidekiq_role, :sidekiq
set :sidekiq_cmd, "#{bundle_bin} exec sidekiq"
set :sidekiqctl_cmd, "#{bundle_bin} exec sidekiqctl"
set :sidekiq_timeout, 10
set :sidekiq_role, :sidekiq
set :sidekiq_pid, "#{current_path}/tmp/pids/sidekiq.pid"
set :sidekiq_processes, 1


role :web, "sac-eng-deploy-web-01.unix.newokl.com" 
role :app, "sac-eng-deploy-web-01.unix.newokl.com"
role :db,  "sac-eng-deploy-web-01.unix.newokl.com", :primary => true
role :sidekiq, 'sac-eng-deploy-web-01.unix.newokl.com'

before  "bundle:install"          , "deploy:config_bundler"
after   "deploy:update_code"      , "deploy:migrate"
after   "deploy:update_code"      , "deploy:cleanup"

namespace :deploy do
  task :config_bundler do
    # Not sure why it's not picking up bundle_cmd
    run "cd #{release_path} && #{bundle_bin} config build.mysql2 --with-mysql-config=#{mysql_home}/bin/mysql_config"
  end
  
  task :migrate, :roles => :db, :only => { :primary => true } do
    run "cd #{release_path}; #{rake} RAILS_ENV=#{environment} db:migrate"
  end
  
  task :start do ; end
  task :stop do ; end
  
  desc "Restart passenger"
  task :restart, :roles => :app, :except => { :no_release => true } do
     run "touch #{current_path}/tmp/restart.txt"
  end


end
