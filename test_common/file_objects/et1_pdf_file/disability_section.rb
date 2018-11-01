module EtFullSystem
  module Test
    module FileObjects
      module Et1PdfFileSection
        class DisabilitySection < Base
          def has_contents_for?(claimant:, errors:, indent:)
            validate_fields section: :disability, errors: errors, indent: indent do
              expected_values = {
                  has_special_needs: yes_no_for(claimant.special_needs.present?, yes: 'yes', no: 'no'),
                  special_needs: claimant.special_needs
              }
              expect(mapped_field_values).to include expected_values
            end
          end
        end
      end
    end
  end
end
