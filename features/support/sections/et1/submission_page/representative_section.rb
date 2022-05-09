require_relative './base_section'
module EtFullSystem
  module Test
    module Et1
      module SubmissionPageSections
        class RepresentativeSection < BaseSection
          section :type_of_representative, :govuk_summary_list_row,
                  :'review.representative.questions.type_of_representative' do
            element :answer, :govuk_summary_list_col
          end
          section :email, :govuk_summary_list_row, :'review.representative.questions.email' do
            element :answer, :govuk_summary_list_col
          end
          section :address, :govuk_summary_list_row, :'review.representative.questions.address' do
            include ::EtFullSystem::Test::I18n
            include RSpec::Matchers
            element :answer, :govuk_summary_list_col

            def has_answer_for?(rep)
              if rep.building.nil? && rep.street.nil? && rep.locality.nil? && rep.county.nil? && rep.post_code.nil?
                expect(self).to have_answer(text: t('review.common.not_entered'))
              else
                expect(self).to have_answer(text: "#{rep.building}#{rep.street}#{rep.locality}#{rep.county}#{rep.post_code}")
              end
              true
            end
          end
          section :full_name, :govuk_summary_list_row, :'review.representative.questions.full_name' do
            element :answer, :govuk_summary_list_col
          end
          section :dx_number, :govuk_summary_list_row, :'review.representative.questions.dx_number' do
            element :answer, :govuk_summary_list_col
          end
          section :mobile, :govuk_summary_list_row, :'review.representative.questions.mobile' do
            element :answer, :govuk_summary_list_col
          end
          section :preferred_contact, :govuk_summary_list_row, :'review.representative.questions.preferred_contact' do
            element :answer, :govuk_summary_list_col
          end
          section :phone, :govuk_summary_list_row, :'review.representative.questions.phone' do
            element :answer, :govuk_summary_list_col
          end
          section :organisation_name, :govuk_summary_list_row, :'review.representative.questions.organisation_name' do
            element :answer, :govuk_summary_list_col
          end
          section :representative, :govuk_summary_list_row, :'review.representative.questions.representative' do
            element :answer, :govuk_summary_list_col
          end

          def has_correct_translation?(representative:)
            if representative.nil?
              expect(representative).to have_answer(text: t('review.common.no'))
            else
              aggregate_failures 'validating representative section' do
                expect(type_of_representative).to have_answer(text: with_not_entered(factory_translate(representative.type)))
                expect(email).to have_answer(text: with_not_entered(representative.email_address))
                expect(address).to have_answer_for(representative)
                expect(full_name).to have_answer(text: with_not_entered(representative.name))
                expect(dx_number).to have_answer(text: with_not_entered(representative.dx_number))
                expect(mobile).to have_answer(text: with_not_entered(representative.alternative_telephone_number))
                expect(phone).to have_answer(text: with_not_entered(representative.telephone_number))
                expect(preferred_contact).to have_answer(text: with_not_entered(factory_translate(representative.representative_contact_preference)))
                expect(organisation_name).to have_answer(text: with_not_entered(representative.organisation_name))
                expect(self).to have_no_representative
              end
            end
            true
          end
        end
      end
    end
  end
end
