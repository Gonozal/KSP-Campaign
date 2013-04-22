rails_env = ENV['RAILS_ENV'] || 'development'

threads 4,4

bind  "unix:///apps/ksp_campaign/shared/tmp/puma/appname-puma.sock"
pidfile "/apps/ksp_campaign/current/tmp/puma/pid"
state_path "/apps/ksp_campaign/current/tmp/puma/state"

activate_control_app
