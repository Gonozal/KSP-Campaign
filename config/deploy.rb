require 'bundler/capistrano'

# Has to be configured before require.. weird capistrano
set :rvm_ruby_string, :local               # use the same ruby as used locally for deployment
set :rvm_autolibs_flag, "read-only"        # more info: rvm help autolibs

before 'deploy:setup', 'rvm:install_rvm'   # install RVM
before 'deploy:setup', 'rvm:install_ruby'  # install Ruby and create gemset, OR:
before 'deploy:setup', 'rvm:create_gemset' # only create gemset

require "rvm/capistrano"

#========================
#CONFIG
#========================
set :application, "ksp_campaign"
set :scm, :git
set :repository, "git@github.com:Gonozal/KSP-Campaign.git"
set :branch, "master"
set :ssh_options, { :forward_agent => true }
set :stage, :production
set :user, "rails"
set :use_sudo, false
set :runner, "rails"
set :deploy_to, "/home/#{user}/apps/#{application}"
set :deploy_via, :remote_cache
set :app_server, :puma
set :domain, "ksp-campaign.arnelink.eu"
set :normalize_asset_timestamps, false
default_run_options[:pty]   = true
#========================
#ROLES
#========================
role :app, domain
role :web, domain
role :db, domain, :primary => true
#========================
#CUSTOM
#========================
namespace :puma do
  desc "Start Puma"
  task :start, :except => { :no_release => true } do
    run "#{sudo} start puma app=#{release_path}"
  end
  after "deploy:start", "puma:start"

  desc "Stop Puma"
  task :stop, :except => { :no_release => true } do
    run "#{sudo} start puma app=#{release_path}"
  end
  after "deploy:stop", "puma:stop"

  desc "Restart Puma"
  task :restart, roles: :app do
    run "#{sudo} start puma app=#{release_path}"
  end
  after "deploy:restart", "puma:restart"

  desc "create a shared tmp dir for puma state files"
  task :after_symlink, roles: :app do
    run "rm -rf #{release_path}/tmp"
    run "ln -s #{shared_path}/tmp #{release_path}/tmp"
  end
  after "deploy:create_symlink", "puma:after_symlink"

  desc "create needed shared folders"
  task :setup_puma_folder, roles: :app do
    run "mkdir -p #{shared_path}/tmp"
    run "mkdir -p #{shared_path}/tmp/puma"
  end
  after "deploy:setup", "puma:setup_puma_folder"
end

