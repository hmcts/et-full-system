require_relative 'features/support/configuration'
require "parallel_tests/tasks"
require 'aws-sdk-s3'
require 'azure/storage'
desc 'Configures the buckets needed by the applications (local environment only)'
task :setup_buckets do
  config = {
      region: ENV.fetch('AWS_REGION', 'us-east-1'),
      access_key_id: ENV.fetch('AWS_ACCESS_KEY_ID', 'accessKey1'),
      secret_access_key: ENV.fetch('AWS_SECRET_ACCESS_KEY', 'verySecretKey1'),
      endpoint: ENV.fetch('AWS_ENDPOINT', 'http://s3.et.127.0.0.1.nip.io:3100/'),
      force_path_style: ENV.fetch('AWS_S3_FORCE_PATH_STYLE', 'true') == 'true'
  }
  s3 = Aws::S3::Client.new(config)
  retry_countdown = 10
  begin
    Aws::S3::Bucket.new(client: s3, name: 'et1bucket').tap do |bucket|
      bucket.create unless bucket.exists?
    end
    Aws::S3::Bucket.new(client: s3, name: 'etapibucket').tap do |bucket|
      bucket.create unless bucket.exists?
    end
  rescue Seahorse::Client::NetworkingError, Aws::S3::Errors::NotFound, Aws::S3::Errors::Http502Error, Aws::Errors::ServiceError
    retry_countdown -= 1
    if retry_countdown.zero?
      fail "Could not connect to the S3 server after 10 retries"
    else
      STDERR.puts "Retrying connection to S3 server in 30 seconds"
      sleep 30
      retry
    end
  end
end

desc "Report et1 lost claims since aug 2018"
task :et1_lost_claims do
  et1_file = File.absolute_path('./et1_submitted.csv', __dir__)
  api_file = File.absolute_path('./api_received.csv', __dir__)

  et1_rows = 0
  api_refs = []
  et1_refs = []
  missing = []
  CSV.foreach(api_file, headers: true) do |row|
    api_refs << row[0]
  end
  CSV.foreach(et1_file, headers: true) do |row|
    et1_rows += 1
    next if api_refs.include?(row[0])
    missing << row
  end

  puts "A total of #{missing.length} ET1 claims have been reported from a total of #{et1_rows}"
  puts "fee_group_reference,state,created_at,updated_at,submitted_at,email_address,application_reference"

  missing.each do |row|
    puts row.to_csv
  end
end
