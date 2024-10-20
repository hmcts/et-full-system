module EtFullSystem
  module Test
    module Et3ResponseHelper
      def start_a_new_et3_response
        load_et3_start_page
        start_page.next
        et3_answer_saving_response
      end

      def load_et3_start_page(in_language: ::EtFullSystem::Test::Messaging.instance.current_locale)
        start_page.load
        case in_language
        when :cy then start_page.switch_to_welsh
        when :en then nil
        else raise "We only support languages en and cy - #{in_language} is not supported"
        end
        start_page.assert_language(in_language)
      end

      def et3_answer_respondents_details
        user = @respondent[0]
        respondents_details_page.case_number_question.set(user.case_number)
        respondents_details_page.company_number_question.set(user.company_number)
        respondents_details_page.title_question.set(user.title)
        respondents_details_page.title_other_question.set(user.title_other) if(user.title == 'Other')
        respondents_details_page.name_question.set(user.name)
        respondents_details_page.contact_question.set(user.contact)
        respondents_details_page.building_name_question.set(user.building_name)
        respondents_details_page.street_question.set(user.street_name)
        respondents_details_page.town_question.set(user.town)
        respondents_details_page.county_question.set(user.county)
        respondents_details_page.postcode_question.set(user.postcode)
        respondents_details_page.dx_number_question.set(user.dx_number)
        respondents_details_page.contact_number_question.set(user.contact_number)
        respondents_details_page.contact_mobile_number_question.set(user.contact_mobile_number)
        respondents_details_page.contact_preference_question.set(user.contact_preference.to_s.split('.').last&.to_sym)
        respondents_details_page.email_address_question.set(user.email_address) if user.contact_preference.to_s.split('.').last == 'email'
        respondents_details_page.organisation_more_than_one_site_question.set(user.organisation_more_than_one_site.to_s.split('.').last.to_sym)
        respondents_details_page.employment_at_site_number_question.set(user.employment_at_site_number) if user.organisation_more_than_one_site.to_s.split('.')[-2] == 'yes'
        respondents_details_page.organisation_employ_gb_question.set(user.organisation_employ_gb)
        respondents_details_page.allow_phone_or_video_attendance_question.set(user.allow_phone_orvideo_attendance)

        respondents_details_page.next
      end

      def et3_answer_saving_response
        saving_response_page.set
        saving_response_page.save_and_continue
      end

      def et3_answer_required_espondents_details
        user = @respondent[0]
        respondents_details_page.case_number_question.set(user.case_number)
        respondents_details_page.name_question.set(user.name)
        respondents_details_page.building_name_question.set(user.building_name)
        respondents_details_page.street_question.set(user.street_name)
        respondents_details_page.town_question.set(user.town)
        respondents_details_page.postcode_question.set(user.postcode)
        respondents_details_page.organisation_more_than_one_site_question.set(user.organisation_more_than_one_site.to_s.split('.').last.to_sym)

        respondents_details_page.next
      end

      def et3_answer_claimants_details
        user = @claimant[0]
        claimants_details_page.claimants_name_question.set(user.claimants_name)
        claimants_details_page.agree_with_early_conciliation_details_question.set(user.agree_with_early_conciliation_details.to_s.split('.').last.to_sym)
        claimants_details_page.disagree_conciliation_reason.set(user.disagree_conciliation_reason) if user.agree_with_early_conciliation_details.to_s.split('.').last == 'no'
        claimants_details_page.agree_with_employment_dates_question.set(user.agree_with_employment_dates.to_s.split('.').last.to_sym)
        if user.agree_with_employment_dates.to_s.split('.').last == 'no'
          claimants_details_page.employment_start.set(user.employment_start)
          claimants_details_page.employment_end.set(user.employment_end)
          claimants_details_page.disagree_employment.set(user.disagree_employment)
        end
        claimants_details_page.continued_employment_question.set(user.continued_employment.to_s.split('.').last.to_sym)
        claimants_details_page.agree_with_claimants_description_of_job_or_title_question.set(user.agree_with_claimants_description_of_job_or_title.to_s.split('.').last.to_sym)
        if user.agree_with_claimants_description_of_job_or_title.to_s.split('.').last == 'no'
          claimants_details_page.disagree_claimants_job_or_title.set(user.disagree_claimants_job_or_title)
        end
        claimants_details_page.next
      end

      def et3_answer_required_claimants_details
        user = @claimant[0]
        claimants_details_page.agree_with_employment_dates_question.set(user.agree_with_employment_dates.to_s.split('.').last.to_sym)
        if user.agree_with_employment_dates.to_s.split('.').last == 'no'
          claimants_details_page.employment_start.set(user.employment_start)
          claimants_details_page.employment_end.set(user.employment_end)
          claimants_details_page.disagree_employment.set(user.disagree_employment)
        end

        claimants_details_page.next
      end

      def et3_answer_earnings_and_benefits
        user = @claimant[0]
        earnings_and_benefits_page.agree_with_claimants_hours_question.set(user.agree_with_claimants_hours.to_s.split('.').last.to_sym)
        earnings_and_benefits_page.queried_hours.set(user.queried_hours)
        earnings_and_benefits_page.agree_with_earnings_details_question.set(user.agree_with_earnings_details.to_s.split('.').last.to_sym)
        if user.agree_with_earnings_details.to_s.split('.').last == 'no'
          earnings_and_benefits_page.queried_pay_before_tax.set(user.queried_pay_before_tax)
          earnings_and_benefits_page.queried_pay_before_tax_period.set(user.queried_pay_before_tax_period.to_s.split('.').last.to_sym)
          earnings_and_benefits_page.queried_take_home_pay.set(user.queried_take_home_pay)
          earnings_and_benefits_page.queried_take_home_pay_period.set(user.queried_take_home_pay_period.to_s.split('.').last.to_sym)
        end
        earnings_and_benefits_page.agree_with_claimant_notice_question.set(user.agree_with_claimant_notice.to_s.split('.').last.to_sym)
        if user.agree_with_claimant_notice.to_s.split('.').last == 'no'
          earnings_and_benefits_page.disagree_claimant_notice_reason.set(user.disagree_claimant_notice_reason)
        end
        earnings_and_benefits_page.agree_with_claimant_pension_benefits_question.set(user.agree_with_claimant_pension_benefits.to_s.split('.').last.to_sym)
        if user.agree_with_claimant_pension_benefits.to_s.split('.').last == 'no'
          earnings_and_benefits_page.disagree_claimant_pension_benefits_reason.set(user.disagree_claimant_pension_benefits_reason)
        end

        earnings_and_benefits_page.next
      end

      def et3_answer_defend_claim_question
        user = @claimant[0]
        response_page.defend_claim_question.set(user.defend_claim)
        if user.defend_claim.to_s.split('.').last == 'yes'
          response_page.defend_claim_facts.set(user.defend_claim_facts)
        end

        response_page.next
      end

      def et3_answer_representative
        user = @representative[0]
        if user.representative_have.to_s.split('.').last == "yes"
          your_representative_page.representative_question.set(:yes)
          your_representative_page.next
          your_representatives_details_page.type_of_representative_question.set(user.type.to_s.split('.').last.to_sym)
          your_representatives_details_page.representative_org_name_question.set(user.organisation_name)
          your_representatives_details_page.representative_name_question.set(user.name)
          your_representatives_details_page.representative_building_question.set(user.building)
          your_representatives_details_page.representative_street_question.set(user.street)
          your_representatives_details_page.representative_town_question.set(user.locality)
          your_representatives_details_page.representative_county_question.set(user.county)
          your_representatives_details_page.representative_postcode_question.set(user.post_code)
          your_representatives_details_page.representative_phone_question.set(user.telephone_number)
          your_representatives_details_page.representative_mobile_question.set(user.representative_mobile)
          your_representatives_details_page.representative_dx_number_question.set(user.dx_number)
          your_representatives_details_page.representative_reference_question.set(user.representative_reference)
          your_representatives_details_page.representative_contact_preference_question.set(user.representative_contact_preference)
          if user.representative_contact_preference.end_with?('.email')
            your_representatives_details_page.preference_email.set(user.representative_email)
          end
          your_representatives_details_page.allow_phone_or_video_attendance_question.set(user.allow_phone_or_video_attendance)
          your_representatives_details_page.next
        else
          your_representative_page.next
        end

      end

      def et3_answer_disability_question
        user = @respondent[0]
        disability_page.disability_question.set(user.disability.to_s.split('.').last&.to_sym)
        if user.disability&.end_with?('.yes') && user.disability_information != nil
          disability_page.disability_information.set(user.disability_information)
        end

        disability_page.next
      end

      def et3_employers_contract_claim
        user = @respondent[0]
        employers_contract_claim_page.make_employer_contract_claim_question.set(user.make_employer_contract_claim.to_s.split('.').last.to_sym)
        if user.make_employer_contract_claim.end_with?('yes')
          employers_contract_claim_page.claim_information.set(user.claim_information)
        end

        employers_contract_claim_page.next
      end

      def et3_answer_no_to_employers_contract_claim
        employers_contract_claim_page.make_employer_contract_claim_question.set(:no)

        employers_contract_claim_page.next
      end

      def et3_displays_edited_answer
        make_employer_contract_claim_row.make_employer_contract_claim_answer.text
      end

      def additional_information
        user = @respondent[0]
        if user[:rtf_file]
          additional_information_page.attach_additional_information_file(user)
        end
        additional_information_page.next
      end

      def et3_confirmation_of_supplied_details
        user = @respondent[0]
        confirmation_of_supplied_details_page.email_receipt_question.set(user.email_receipt)
        confirmation_of_supplied_details_page.next
      end

      def et3_edit_answer
        confirmation_of_supplied_details_page.confirmation_of_employer_contract_claim_answers.edit_answers_link.click
      end

      def et3_displays_edited_answer
        confirmation_of_supplied_details_page.confirmation_of_employer_contract_claim_answers.make_employer_contract_claim_row.make_employer_contract_claim_answer.text
      end
    end
  end
end
