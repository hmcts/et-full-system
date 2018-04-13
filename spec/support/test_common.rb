require_relative '../../test_common/capybara'
require_relative '../../test_common/page_objects'
require_relative '../../test_common/personas'
require_relative '../../test_common/messaging'
require_relative '../../test_common/helpers'
require_relative '../../test_common/common_admin_window'

RSpec.configure do |c|
  c.include EtFullSystem::Test::Pages, type: :feature
end
RSpec.configure do |c|
  c.include EtFullSystem::Test::Setup, type: :feature
end
RSpec.configure do |c|
  c.include EtFullSystem::Test::Et1ClaimHelper, type: :feature
end