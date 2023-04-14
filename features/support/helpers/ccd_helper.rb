module EtFullSystem
  module Test
    module CcdHelper
      def ccd
        return @ccd if defined?(@ccd)
        @ccd = ::EtCcdClient::UiClient.new
        @ccd.login(username: ::EtFullSystem::Test::Configuration.ccd_sidam_username, password: ::EtFullSystem::Test::Configuration.ccd_sidam_password)
        @ccd
      end

      def find_or_create_any_claim_in_ccd
        ccd_office_lookup = ::EtFullSystem::Test::CcdOfficeLookUp
        ccd_object = EtFullSystem::Test::Ccd::Et1CcdSingleClaimant.
            find_latest(ccd_office_lookup.office_lookup[:manchester][:single][:case_type_id])
        return ccd_object unless ccd_object.nil? || ccd_object.ethos_case_reference.nil? || ccd_object.ethos_case_reference !=~ /\A\d\d\d\d\d\d\d\/\d\d\d\d\z/

        create_any_claim_in_ccd
      end

      def create_any_claim_in_ccd
        ccd_office_lookup = ::EtFullSystem::Test::CcdOfficeLookUp
        @claimant = FactoryBot.create_list(:claimant, 1, :person_data)
        @representative = FactoryBot.create_list(:representative, 1, :et1_information)
        @respondent = FactoryBot.create_list(:respondent,  1, :yes_acas, :both_addresses, work_post_code: 'M1 1AQ', expected_office: '24')
        @employment = FactoryBot.create(:employment, :still_employed)
        @claim = FactoryBot.create(:claim, :yes_to_whistleblowing_claim)
        start_a_new_et1_claim
        et1_answer_login
        et1_answer_claimant_questions
        et1_answer_group_claimants_questions
        et1_answer_representatives_questions
        et1_answer_respondents_questions
        et1_answer_employment_details_questions
        et1_answer_claim_type_questions
        et1_answer_claim_details_questions
        et1_answer_claim_outcome_questions
        et1_answer_more_about_the_claim_questions
        et1_submit_claim
        EtFullSystem::Test::Ccd::Et1CcdSingleClaimant.find_and_wait_for_latest(ccd_office_lookup.office_lookup['24'][:single][:case_type_id]).tap do |result|
          raise "No claims were present in CCD and for some reason one could not be created - suggests a problem with the app or maybe a wrong office code" if result.nil?
        end
      end

      def create_reformed_claim_in_ccd(office_code:)
        office_lookup = ::EtFullSystem::Test::CcdOfficeLookUp.office_lookup
        case_type_id = office_lookup[office_code.to_s][:single][:case_type_id]

        resp = ccd.caseworker_start_case_creation(case_type_id: case_type_id, extra_headers: {})
        data = {
          data: {
            receiptDate: '2023-01-01',
            caseSource: 'ET1 Online',
            feeGroupReference: "#{office_code}1234567890",
            managingOffice: "Bristol",
            claimant_TypeOfClaimant: 'Individual',
            positionType: 'Received by Auto-Import',
            claimantIndType: {
              claimant_title1: 'Mr',
              claimant_first_names: 'John',
              claimant_last_name: 'Smith',
              claimant_date_of_birth: '1980-01-01',
              claimant_gender: nil,
            },
            claimantType: {
              claimant_addressUK: {
                AddressLine1: '1 High Street',
                AddressLine2: 'Bla',
                PostTown: 'London',
                County: 'London',
                Country: nil,
                PostCode: 'SW1A 1AA'
              },
              claimant_phone_number: '01234567890',
              claimant_mobile_number: '01234567890',
              claimant_email_address: 'test@test.com',
              claimant_contact_preference: 'Email'
            },
            caseType: 'Single',
            claimantWorkAddress: {
              claimant_work_address: {
                AddressLine1: '1 High Street',
                AddressLine2: 'Bla',
                PostTown: 'London',
                County: 'London',
                Country: nil,
                PostCode: 'SW1A 1AA'
              },
              claimant_work_phone_number: '01234567890'
            },
            respondentCollection: [],
            claimantOtherType: {
              claimant_disabled: 'No'
            },
            claimantRepresentedQuestion: 'No',
            documentCollection: []
          },
          event: {
            id: 'initiateCase',
            summary: '',
            description: ''
          },
          event_token: resp['token'],
          ignore_warning: false,
          draft_id: nil
        }

        ccd.caseworker_case_create(data.to_json, case_type_id: case_type_id, extra_headers: {})
      end
    end
  end
end
