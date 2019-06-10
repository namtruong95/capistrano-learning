namespace :cloudfront do
  task :invalidation do
    files = fetch(:exclusions)

    s3 = Capistrano::S3::Publisher.establish_s3_client_connection!(
      fetch(:region),
      fetch(:access_key_id),
      fetch(:secret_access_key)
    )

    files.each do |file_path|
      mime_type = MIME::Types.type_for(file_path)

      File.open("#{fetch(:deployment_path)}/#{file_path}", 'rb') do |file|
        s3.put_object({
          body: file,
          bucket: fetch(:bucket),
          key: file_path,
          content_type: mime_type[0].content_type
        })
      end
    end
  end
end
