module EtFullSystem
  module Test
    module Admin
      class ExportPage < Admin::BasePage
        section :event, :admin_export_event_row do

        end
        def assert_erroring_event(message)
          event(erroring_with_message: message)
        end
      end
    end
  end
end