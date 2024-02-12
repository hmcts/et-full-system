source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

group :test do
  gem 'rspec', '~> 3.7'
  gem 'capybara', '~> 3.10'
  gem 'site_prism', '~> 3.7'
  gem 'i18n', '~> 1.8'
  gem 'activesupport', '~> 7.0'
  gem 'selenium-webdriver', '~> 4.7'
  gem 'webdrivers', '~> 5.2'
  gem 'capybara-screenshot', '~> 1.0'
  gem 'cucumber', '~> 9.0'
  gem 'aws-sdk-s3', '~> 1.9'
  gem 'azure-storage', '~> 0.15.0.preview', require: false

  # Rubyzip used to test zip files
  gem 'rubyzip', '~> 2.3'
  # HTTParty - used to download from ATOS API during tests
  gem 'httparty', '~> 0.18'
  gem 'mechanize', '~> 2.7', '>= 2.7.6'
  gem 'pry'
  # Pdf forms to test pdf content
  gem 'pdf-forms', '~> 1.1', '>= 1.1.1'
  gem 'factory_bot'
  gem 'settingslogic'
  gem 'mail'
  gem 'et_ccd_client', git: 'https://github.com/hmcts/et-ccd-client-ruby.git', tag: 'v0.4.0'
  gem 'et_test_helpers', git: 'https://github.com/hmcts/et_test_helpers.git', tag: 'v1.3.2'

  # rtf and pdf file reader
  gem 'ruby-rtf', '~> 0.0.5'
  gem 'pdf-reader', '~> 2.11.0'
end

group :development, :test do
  gem 'dotenv', '~> 2.2', '>= 2.2.2'
  gem 'faker', '~> 2.0'
  gem 'parallel_tests'
  gem 'ruby-debug-ide'
  gem 'debase'
end

gem 'thor', '~> 0.20.3'
gem 'rake'
