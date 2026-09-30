module EtFullSystem
  module Test
    module Ccd
      class Base
        def self.ccd
          return @ccd if defined?(@ccd)

          @ccd = ::EtCcdClient::UiClient.new
          @ccd.login(username: ::EtFullSystem::Test::Configuration.ccd_sidam_username,
                     password: ::EtFullSystem::Test::Configuration.ccd_sidam_password)
          @ccd
        end

        def ccd
          self.class.ccd
        end
      end
    end
  end
end
