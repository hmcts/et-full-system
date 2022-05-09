module EtFullSystem
  module Test
    module Admin
      class DefaultOfficeClaimsPage < Admin::BasePage
        set_url "/default_office_claims"
        section :scopes, :css, '.table_tools .scopes' do
          section :not_exported_to_ccd_button, :xpath, XPath.generate {|x| x.descendant(:li)[x.child(:a)[x.string.n.starts_with('Not Exported To Ecm')]]} do
            element :link, :css, 'a'
          end
          section :not_exported_to_ccd_button_selected, :xpath, XPath.generate {|x| x.css('li.selected')[x.child(:a)[x.string.n.starts_with('Not Exported To Ecm')]]} do
            element :link, :css, 'a'
          end
        end
        section :main_table, 'table.index' do
          section :row_with_reference, :admin_claim_row do

            element :failed_ccd_state_link, :link, "failed"
            element :erroring_ccd_state_link, :link, "erroring"
            element :checkbox, :checkbox

            def select_row
              checkbox.check
            end
          end

          def select_claim_with_reference(reference)
            row_with_reference(reference: reference).select_row
          end
        end
        section :batch_actions, :xpath, XPath.generate {|x| x.descendant(:div)[x.child(:a)[x.string.n.equals 'Batch Actions']]} do
          element :link, :link, 'Batch Actions'
          element :export_selected_link, :link, 'Export Selected'
          def select_export_selected
            link.click
            export_selected_link.click
            sleep 10
          end
        end

        section :office_chooser, :xpath, XPath.generate {|x| x.css('.ui-dialog')[x.child(:div)[x.string.n.starts_with 'Are you sure you want to do this?']]} do
          element :office_selector, :css, 'select'
          element :ok_button, :button, 'OK'
          element :cancel_button, :button, 'Cancel'
          def choose_office(external_system_name)
            option = office_selector.find(:option, external_system_name)
            option.select_option
            ok_button.click
          end
        end

        section :flash_messages, :css, '.flashes' do
          element :claims_queued_for_export, :xpath, XPath.generate {|x| x.descendant(:div)[x.string.n.starts_with 'Claims queued for export']}
        end


        def list_not_exported_to_ccd
          scopes.not_exported_to_ccd_button.link.click
          scopes.not_exported_to_ccd_button_selected
        end

        def export_claim(reference, external_system_name)
          main_table.select_claim_with_reference(reference)
          batch_actions.select_export_selected
          office_chooser.choose_office(external_system_name)
          flash_messages.claims_queued_for_export
        end

        def follow_export_for_failed_ccd_state(reference)
          row = main_table.row_with_reference(reference: reference)
          row.failed_ccd_state_link.click
        end

        def follow_export_for_erroring_ccd_state(reference)
          row = main_table.row_with_reference(reference: reference)
          row.erroring_ccd_state_link.click
        end
      end
    end
  end
end