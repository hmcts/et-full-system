Then('garys stuff should work') do
  case_type_id='Manchester_Dev'
  resp = ccd.caseworker_start_case_creation(case_type_id: case_type_id, extra_headers: {})
  data = {
    data: {
      receiptDate: '2023-01-01',
      caseSource: 'ET1 Online',
      feeGroupReference: '601234567890',
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

  create_result = ccd.caseworker_case_create(data.to_json, case_type_id: case_type_id, extra_headers: {})
  ethos_case_reference = create_result.dig('case_fields', 'ethosCaseReference')

  result = ccd.caseworker_search_latest_by_ethos_case_reference(ethos_case_reference, case_type_id: case_type_id)
  result
end
