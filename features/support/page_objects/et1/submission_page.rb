module EtFullSystem
  module Test
    module Et1
      class SubmissionPage < BasePage
        include RSpec::Matchers
        #Check your claim
        section :main_header, '.main-header' do
          element :page_header, :main_header, 'claim_reviews.show.header', exact: false
        end
        include EtFullSystem::Test::I18n
        section :group_claim_section, SubmissionPageSections::GroupClaimSection, :govuk_summary_list, :'review.group_claim.title'
        section :additional_respondents_section, SubmissionPageSections::AdditionalRespondentsSection, :govuk_summary_list, :'review.additional_respondents.title'
        section :additional_information_section, SubmissionPageSections::AdditionalInformationSection, :govuk_summary_list, :'review.additional_information.title'
        section :claim_details_section, SubmissionPageSections::ClaimDetailsSection,:govuk_summary_list, :'review.claim_details.title'
        section :claim_outcome_section, SubmissionPageSections::ClaimOutcomeSection,  :govuk_summary_list, :'review.claim_outcome.title'
        section :claim_type_section, SubmissionPageSections::ClaimTypeSection, :govuk_summary_list, :'review.claim_type.title'
        section :claimant_section, SubmissionPageSections::ClaimantSection,:govuk_summary_list, :'review.claimant.title'
        section :employment_section, SubmissionPageSections::EmploymentSection ,:govuk_summary_list, :'review.employment.title'
        section :representative_section, SubmissionPageSections::RepresentativeSection,:govuk_summary_list, :'review.representative.title'
        section :respondent_section, SubmissionPageSections::RespondentSection,:govuk_summary_list, :'review.respondent.title'

        gds_submit_button :submit_claim_button, :'review.submit_claim'

        def submit_claim
          submit_claim_button.click
        end

        def switch_to_welsh
          feedback_notice.welsh_link.click
        end

        def switch_to_english
          feedback_notice.english_link.click
        end

        def has_correct_translation?(claimants:, respondents:, claim:, employment:, representative:)
          expect(group_claim_section).to have_correct_translation(claimants: claimants)
          expect(additional_respondents_section).to have_correct_translation(respondents: respondents)
          expect(additional_information_section).to have_correct_translation(claim: claim)
          expect(claim_details_section).to have_correct_translation(claim: claim)
          expect(claim_outcome_section).to have_correct_translation(claim: claim)
          expect(claim_type_section).to have_correct_translation(claim: claim)
          expect(claimant_section).to have_correct_translation(claimant: claimants.first)
          expect(employment_section).to have_correct_translation(employment: employment)
          expect(representative_section).to have_correct_translation(representative: representative)
          expect(respondent_section).to have_correct_translation(respondent: respondents.first)
          expect(self).to have_submit_claim_button
          true
        end
      end
    end
  end
end
