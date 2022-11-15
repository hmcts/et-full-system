require 'rspec/matchers'
module EtFullSystem
  module Test
    module Admin
      class AcasSearchResultsPage < Admin::BasePage
        include ::RSpec::Matchers
        section :search_fieldset, :fieldset, 'ACAS Search' do
          element :search_field, :fillable_field, 'Please enter your ACAS Early Conciliation Certificate number*'
        end

        element :search_button, 'fieldset.actions input[value=Search]'
        section :search_results, '.search-results' do
          section :respondent_section, :xpath, XPath.generate {|x| x.descendant(:div)[x.child(:h3)[x.string.n.is('Respondent')]]} do
            section :acas_first_contact, :xpath, XPath.generate {|x| x.descendant(:tr)[x.child(:th)[x.string.n.is('ACAS first contact')]]} do
              element :value_element, 'td'
            end
            section :acas_conciliation_closed, :xpath, XPath.generate {|x| x.descendant(:tr)[x.child(:th)[x.string.n.is('ACAS conciliation closed')]]} do
              element :value_element, 'td'
            end
            section :difference, :xpath, XPath.generate {|x| x.descendant(:tr)[x.child(:th)[x.string.n.is('Difference')]]} do
              element :value_element, 'td'
            end
            section :certificate_sent, :xpath, XPath.generate {|x| x.descendant(:tr)[x.child(:th)[x.string.n.is('Certificate sent')]]} do
              element :value_element, 'td'
            end
            section :full_name, :xpath, XPath.generate {|x| x.descendant(:tr)[x.child(:th)[x.string.n.is('Full name')]]} do
              element :value_element, 'td'
            end
          end
          section :lead_claimant_section, :xpath, XPath.generate {|x| x.descendant(:div)[x.child(:h3)[x.string.n.is('Lead Claimant')]]} do
            section :full_name, :xpath, XPath.generate {|x| x.descendant(:tr)[x.child(:th)[x.string.n.is('Full name')]]} do
              element :value_element, 'td'
            end
          end
          section :certificate_section, :xpath, XPath.generate {|x| x.descendant(:div)[x.child(:h3)[x.string.n.is('Certificate')]]} do
            section :download, :xpath, XPath.generate {|x| x.descendant(:tr)[x.child(:th)[x.string.n.is('Certificate download')]]} do
              element :link, 'td a'
            end
          end
        end
        element :search_errors, '.search-errors'

        def search(value)
          search_fieldset.search_field.set(value)
          search_button.click
        end

        def has_invalid_certificate_message_for?(_cert)
          expect(search_errors).to have_content("Please enter a valid certificate number")
        end

        def has_not_found_certificate_message_for?(cert)
          expect(search_errors).to have_content("No certificate returned from ACAS for #{cert.number}")
        end

        def has_server_error_message_for?(_cert)
          expect(search_errors).to have_content("There was a problem with the ACAS service - please try again later")
        end

        def has_download_link_for?(cert)
          expect(search_results.certificate_section.download.link['href']).to start_with "data:application/pdf;base64,"
        end
      end
    end
  end
end
