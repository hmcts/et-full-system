require 'et_ccd_client'

EtCcdClient.config do |c|
  c.idam_base_url = EtFullSystem::Test::Configuration.ccd_idam_base_url
  rewrite = EtFullSystem::Test::Configuration.ccd_document_store_url_rewrite
  c.document_store_url_rewrite = rewrite == false ? false : rewrite.split(':')
  c.gateway_api_url = EtFullSystem::Test::Configuration.ccd_gateway_api_url
  c.sidam_username = EtFullSystem::Test::Configuration.ccd_sidam_username
  c.sidam_password = EtFullSystem::Test::Configuration.ccd_sidam_password
  c.verify_ssl = false
  c.logger = ::ActiveSupport::TaggedLogging.new(Logger.new(STDOUT))
  c.logger.level = ActiveSupport::Logger::WARN
  proxy = EtFullSystem::Test::Configuration['proxy']
  c.proxy = proxy unless proxy.nil? || proxy == false
end
