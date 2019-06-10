# Common
set :group_env, ['PRODUCTION', 'API_URL']

# S3
set :region, ENV["AWS_REGION"] || "us-east-1"
set :bucket, ENV["AWS_BUCKET"] || "sample"
set :access_key_id, ENV["AWS_ACCESS_KEY_ID"] || ""
set :secret_access_key, ENV["AWS_SECRET_ACCESS_KEY"] || ""

set :web_path, "data/#{fetch(:application)}-#{Time.now.to_i}"
set :target_env, :dev # force target_env to dev

# Deployment settings
set :target_path, "dist/html"
set :deployment_path, "#{fetch(:web_path)}/#{fetch(:target_path)}"
set :web_command_build, "cd #{fetch(:web_path)} && yarn build:#{fetch(:target_env)} --output-path=#{fetch(:target_path)}"
set :only_gzip, false
# set :exclusions, %w(index.html)
set :bucket_write_options, {
  cache_control: "max-age=94608000, public"
}
set :redirect_options, { }

# Cloudfront
# set :distribution_id, ENV["AWS_CLOUDFRONT_ID"] || ""
# set :invalidations, fetch(:exclusions)

before "deploy", :run1 do
  invoke "frontend:clone"
  invoke "frontend:install"
  invoke "env:sync:local", "env", "#{fetch(:web_path)}/src/environments/environment.#{fetch(:target_env)}.ts"
  invoke "frontend:build"
end

# after "deploy:published", :run2 do
#   invoke "ssh:publish"
# end

after "deploy:published", :run2 do
  invoke "cloudfront:invalidation"
end

before "deploy:finished", :run3 do
  invoke "frontend:clean"
end
