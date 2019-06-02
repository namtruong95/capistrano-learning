namespace :env do
  namespace :sync do
    task :local, :type, :dist do |task, args|
      run_locally do
        template = open("templates/#{fetch(:application)}/#{args[:type]}.erb", 'r') do |f|
          f.read
        end

        File.open(args[:dist], 'w') do |f|
          envs = ENV.select{ |name| !(name =~ /^APP/).nil? }.transform_keys{ |k| k.sub("APP_", "") }

          f.write ERB.new(template).result(OpenStruct.new(:injects => envs).instance_eval { binding })
        end
      end
    end

    task :cloud, :type, :dist, :prefix do |task, args|
      on roles(:env) do
        template = open("templates/#{fetch(:application)}/#{args[:type]}.erb", 'r') do |f|
          f.read
        end

        pp = args[:prefix].nil? ? 'APP' : args[:prefix].upcase

        envs = ENV.select{ |name| !(name =~ Regexp.new("^#{pp}")).nil? }.transform_keys{ |k| k.sub("#{pp}_", "") }
        content = ERB.new(template).result(OpenStruct.new(:injects => envs).instance_eval { binding })

        upload! StringIO.new(content), args[:dist]
      end
    end
  end
end
