require_relative '../sections'
require_relative '../messaging'
require 'rspec/matchers'
module EtFullSystem
  module Test
    # @abstract
    # @private
    class BasePage < ::SitePrism::Page
      include ::EtFullSystem::Test::I18n
      include ::EtFullSystem::Test::MessageBroadcast
      include EtTestHelpers::Page
      include RSpec::Matchers

      def messaging
        @messaging ||= ::EtFullSystem::Test::Messaging.instance
      end

      def load_page
        load
      end

      def back_via_browser_button
        page.evaluate_script('window.history.back()')
      end

      def load(*)
        super
        broadcast_message(Thread.current[:et_full_system_scenario_name])
      end
    end
  end
end
