namespace :ssh do
  task :publish do
    run_locally do
      on 'server1' do
        execute "rm -rf #{fetch(:deploy_to)}/html"

        upload! "#{fetch(:deployment_path)}", "#{fetch(:deploy_to)}", recursive: true

        execute "pm2 restart #{fetch(:deploy_to)}/ecosystem.config.js"
      end
    end
  end
end
