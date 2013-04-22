#========================
#CONFIG
#========================
set :domain, "ksp-campaign.arnelink.eu"
set :application, "ksp_campaign"
set :use_sudo, false

set :stage, :production
set :deploy_to, "/home/#{user}/apps/#{application}"

set :scm, :git
set :repository, "git@github.com:Gonozal/KSP-Campaign.git"
set :branch, "master"

set :ssh_options, { :forward_agent => true }
set :user, "gonozal"

set :runner, "deploy"
set :app_server, :puma
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
    run "sudo /etc/init.d/puma start #{application}"
  end
  after "deploy:start", "puma:start"

  desc "Stop Puma"
  task :stop, :except => { :no_release => true } do
    run "sudo /etc/init.d/puma stop #{application}"
  end
  after "deploy:stop", "puma:stop"

  desc "Restart Puma"
  task :restart, roles: :app do
    run "sudo /etc/init.d/puma restart #{application}"
  end
  after "deploy:restart", "puma:restart"

  desc "create a shared tmp dir for puma state files"
  task :after_symlink, roles: :app do
    run "sudo rm -rf #{release_path}/tmp"
    run "ln -s #{shared_path}/tmp #{release_path}/tmp"
  end
  after "deploy:create_symlink", "puma:after_symlink"
end
