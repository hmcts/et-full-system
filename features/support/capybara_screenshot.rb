require 'capybara-screenshot/cucumber'

module Capybara
  module Screenshot
    class S3Saver
      def output_screenshot_path
        if html_saved?
          unsigned_url = html_path
          key = unsigned_url.split('/').last
          signer = Aws::S3::Presigner.new client: s3_client
          url = signer.presigned_url(:get_object, bucket: bucket_name, key: key, expires_in: 14400)
          output "HTML screenshot: #{url}"
        end

        if screenshot_saved?
          unsigned_url = screenshot_path
          key = unsigned_url.split('/').last
          signer = Aws::S3::Presigner.new client: s3_client
          url = signer.presigned_url(:get_object, bucket: bucket_name, key: key, expires_in: 14400)
          output "Image screenshot: #{url}"
        end
      end
    end
  end
end

Capybara::Screenshot.register_driver(:firefox) do |driver, path|
  driver.browser.save_screenshot(path)
end

Capybara::Screenshot.register_driver(:firefoxdriver) do |driver, path|
  driver.browser.save_screenshot(path)
end

Capybara::Screenshot.register_driver(:firefoxdriver_headless) do |driver, path|
  driver.browser.save_screenshot(path)
end
