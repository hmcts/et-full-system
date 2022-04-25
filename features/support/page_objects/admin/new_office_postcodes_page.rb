module EtFullSystem
  module Test
    module Admin
      class NewOfficePostcodesPage < Admin::BasePage
        section :select_office_id, 'li[id="office_post_code_office_input"]' do
          def select(value)
            find(:css, '.select2-container').click
            results = find(:xpath, XPath.generate {|x| x.anywhere.descendant(:ul)[x.attr(:id) == 'select2-office_post_code_office_id-results']})
            results.find(:xpath, XPath.generate {|x| x.child(:li)[x.string.n.equals value]}).click
          end
        end
        element :input_postcode, 'input[id="office_post_code_postcode"]'
        element :inline_errors, '.inline-errors'
        element :create_office_post_code, 'input[type="submit"]'
        element :cancel, '.cancel'

        def create_office_postcode(postcode_id, local_office)
          select_office_id.select(local_office)
          input_postcode.set(postcode_id)
          create_office_post_code.click
        end

        def edit_office_address(local_office)
          select_office_id.select(local_office)
          create_office_post_code.click
        end
      end
    end
  end
end
