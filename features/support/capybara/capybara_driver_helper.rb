require 'capybara'
require 'capybara/cuprite'

require_relative '../configuration'
Capybara.configure do |config|
  driver = ENV.fetch('DRIVER', 'cuprite').to_sym
  config.javascript_driver = driver
  config.default_max_wait_time = 10
  config.match = :prefer_exact
  config.exact = true
  config.ignore_hidden_elements = false
  config.visible_text_only = true
end

cuprite_options = {
  'no-sandbox':                  nil,
  'disable-gpu':                 nil,
  'disable-software-rasterizer': nil,
  'disable-dev-shm-usage':       nil,
  'disable-smooth-scrolling':    true,
  'ignore-certificate-errors':    true
}
Capybara.register_driver(:cuprite) do |app|
  Capybara::Cuprite::Driver.new(app,
                                window_size: [1600, 1000],
                                timeout: 10,
                                browser_options: cuprite_options,
                                js_errors: true,
                                process_timeout: 30,
                                browser_timeout: 30,)
end

Capybara.register_driver(:cuprite_visible) do |app|
  Capybara::Cuprite::Driver.new(app,
                                window_size: [1600, 1000],
                                headless: false,
                                timeout: 10,
                                browser_options: cuprite_options,
                                js_errors: true,
                                process_timeout: 30,
                                browser_timeout: 30,)
end

Capybara.always_include_port = true
Capybara.app_host = ENV.fetch('CAPYBARA_APP_HOST', "http://#{ENV.fetch('HOSTNAME', 'localhost')}")
Capybara.server_host = ENV.fetch('CAPYBARA_SERVER_HOST', ENV.fetch('HOSTNAME', 'localhost'))
Capybara.server_port = ENV.fetch('CAPYBARA_SERVER_PORT') if ENV['CAPYBARA_SERVER_PORT']
