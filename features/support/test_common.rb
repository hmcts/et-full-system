require_relative './configuration'
require_relative './capybara'
require_relative './message_broadcast'
require_relative './page_objects'
require_relative './file_objects'
require_relative './messaging'
require_relative './helpers'
require_relative './common_admin_window'
require_relative './rspec_eventually'
require_relative './housekeeping'
require_relative './matchers'
require_relative './api/admin'
require_relative './ccd_config'
require_relative './ccd_support/ccd_office_lookup'
World EtFullSystem::Test::Pages
World EtFullSystem::Test::Et1ClaimHelper
World EtFullSystem::Test::Et3ResponseHelper
World EtFullSystem::Test::DiversityHelper
World EtFullSystem::Test::CommonAdminWindow
World EtFullSystem::Test::Housekeeping
World EtFullSystem::Test::Et1Export
World EtFullSystem::Test::Et3Export
World EtFullSystem::Test::CcdOfficeLookUp
World EtFullSystem::Test::Admin
World EtFullSystem::Test::CcdHelper
World EtFullSystem::Test::SettingsHelper
World EtFullSystem::Test::MessageBroadcast
Before do
  reset_common_admin_window
end
After do
  EtFullSystem::Test::CommonAdminWindow.ensure_admin_window_closed
end
