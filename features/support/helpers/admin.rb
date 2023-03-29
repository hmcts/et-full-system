module EtFullSystem
  module Test
    module Admin
      def admin_api
        EtFullSystem::Test::AdminApi.new
      end

      def admin_pages
        ::EtFullSystem::Test::AdminPages
      end
    end
  end
end
