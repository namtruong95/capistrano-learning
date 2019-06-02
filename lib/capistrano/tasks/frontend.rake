namespace :frontend do
  task :clone do
    run_locally do
      execute "mkdir -p #{fetch(:web_path)}"
      execute "git clone -b #{fetch(:branch)} --single-branch #{fetch(:repo_url)} #{fetch(:web_path)}"
    end
  end

  task :install do
    run_locally do
      execute "cd #{fetch(:web_path)} && NODE_ENV=development yarn install --pure-lockfile"
    end
  end

  task :clean do
    run_locally do
      execute "rm -rf #{fetch(:web_path)}"
    end
  end

  task :build do
    run_locally do
      execute fetch(:web_command_build)
    end
  end
end
