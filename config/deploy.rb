lock "3.8.1"

# capistrano/config
parts = fetch(:stage).split(":")
set :application, parts[0] || ""
set :target_env, parts[1] || ""
set :branch, ENV["branch"] || "develop"
set :repo_url, ENV["REPO_URL"] || ""

# capistrano/ssh
set :format_options, log_file: "logs/#{fetch(:application)}/#{fetch(:target_env)}.log"

SSHKit.config.command_map[:chmod] = "sudo chmod"
SSHKit.config.command_map[:chgrp] = "sudo chgrp"
SSHKit.config.command_map[:chown] = "sudo chown"
SSHKit.config.command_map[:cachetool] = 'sudo cachetool'
SSHKit.config.command_map[:supervisord] = "sudo service supervisord"
SSHKit.config.command_map[:supervisorctl] = "sudo supervisorctl"
