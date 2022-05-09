require_relative './configuration'
require_relative './capybara'
require_relative './message_broadcast'
require_relative './page_objects'
require_relative './file_objects'
require_relative './messaging'
require_relative './helpers'
require_relative './common_admin_window'
require_relative './atos_interface'
require_relative './rspec_eventually'
require_relative './housekeeping'
require_relative './matchers'
require_relative './api/admin'
require_relative './ccd_config'
require_relative './ccd_support/ccd_office_lookup'
include EtFullSystem::Test::Pages
include EtFullSystem::Test::Et1ClaimHelper
include EtFullSystem::Test::Et3ResponseHelper
include EtFullSystem::Test::DiversityHelper
include EtFullSystem::Test::CommonAdminWindow
include EtFullSystem::Test::AtosInterfaceHelper
include EtFullSystem::Test::Housekeeping
include EtFullSystem::Test::Et1Export
include EtFullSystem::Test::Et3Export
include EtFullSystem::Test::CcdOfficeLookUp
include EtFullSystem::Test::Admin
include EtFullSystem::Test::CcdHelper
include EtFullSystem::Test::SettingsHelper
include EtFullSystem::Test::MessageBroadcast
Before do
  EtFullSystem::Test::CommonAdminWindow.reset
end
After do
  EtFullSystem::Test::CommonAdminWindow.ensure_admin_window_closed
end
