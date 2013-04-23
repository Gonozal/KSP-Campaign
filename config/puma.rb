rails_env = ENV['RAILS_ENV'] || 'production'

threads 4,4

bind  "unix:/home/rails/apps/ksp_campaign/shared/tmp/puma/ksp_campaign.sock"
pidfile "/home/rails/apps/ksp_campaign/shared/tmp/puma/pid"
state_path "/home/rails/apps/ksp_campaign/shared/tmp/puma/state"

activate_control_app
