require_relative 'configuration'
require 'httparty'
module EtFullSystem
  module Test
    class WaitForServer
      def initialize(url, timeout: 3600, sleep: 30)
        self.url = url
        self.timeout = timeout
        self.sleep_duration = sleep
      end

      def wait
        Timeout.timeout(timeout) do
          puts "Attempting to access #{url}"
          until request_success(:get, url) do
            puts "Request to #{url} failed - retrying in #{sleep_duration} seconds"
            sleep sleep_duration
          end
        end
      rescue Timeout::Error
        raise "The test suite cannot start as the server cannot be accessed at #{url}"
      end


      private

      def request_success(method, url, options = {})
        proxy = EtFullSystem::Test::Configuration['proxy']
        options = options.merge(verify: false)
        if proxy
          proxy_uri = URI.parse("http://#{proxy}")
          options[:http_proxyaddr] = proxy_uri.host
          options[:http_proxyport] = proxy_uri.port
          options[:http_proxyuser] = proxy_uri.user
          options[:http_proxypass] = proxy_uri.password
        end
        HTTParty.send(method, url, options).success?
      rescue Errno::ECONNREFUSED
        false
      end


      attr_accessor :url, :sleep_duration, :timeout
    end
  end
end
EtFullSystem::Test::WaitForServer.new("#{::EtFullSystem::Test::Configuration.et1_url}/apply/ping.json").wait
EtFullSystem::Test::WaitForServer.new("#{::EtFullSystem::Test::Configuration.et3_url}/ping.json").wait
EtFullSystem::Test::WaitForServer.new("#{::EtFullSystem::Test::Configuration.admin_url.gsub(/\/admin\z/, '')}/ping.json").wait
