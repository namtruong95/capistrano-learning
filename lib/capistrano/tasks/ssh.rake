namespace :ssh do
  task :publish do
    run_locally do
      execute "echo #{fetch(:deploy_to)}"

      on 'server1' do
        upload! "#{fetch(:deployment_path)}", fetch(:deploy_to), recursive: true
      end
    end
  end
end
