module EtFullSystem
  module Test
    module MessageBroadcast
      def broadcast_message(message)
        page&.driver&.browser&.manage&.add_cookie(name: 'zaleniumMessage', value: message)
      rescue Selenium::WebDriver::Error::WebDriverError
        nil
      end
    end
  end
end
World(EtFullSystem::Test::MessageBroadcast)
Before do |scenario|
  Thread.current[:et_full_system_scenario_name] = "#{scenario.name} - #{scenario.location}"
end