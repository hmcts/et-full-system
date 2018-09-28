require_relative './base_page'
module EtFullSystem
  module Test
    module Diversity
      class ReligionPage < BasePage
        section :main_content, '#content .main-section .main-content' do
          element :other_religion, 'input[name="diversities_religion[religion_text]"]'
          element :save_and_continue_button, 'input[value="Save and continue"]'
        end

        def save_and_continue
          main_content.save_and_continue_button.click
        end

        def set_for(answers)
          data = answers.to_h
          if data[:religion] != nil
            if data[:religion] == "Jehovah's Witnesses"
              choose('Any other religion', name: 'diversities_religion[religion]')
              main_content.other_religion.set(data[:religion])
            else
             choose(data[:religion], name: 'diversities_religion[religion]')
            end
          end
          save_and_continue
        end
      end
    end
  end
end

