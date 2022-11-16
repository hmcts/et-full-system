@javascript
Feature:
  As an ACAS administrator
  I want to download a certificate/document from the ET Admin
  So I can validate the certificate number and its contents
  And view logs detailing user access and error messages

  Scenario: Download a ACAS Certificate
   Given I am an ACAS administrator
   When I enter an ACAS certificate number in the ACAS search field
   Then I can download the contents of the acas document


  Scenario: ACAS Certificate logging for Certificate found
    When an ET Administrator with full access can view successful Acas Certificate log
    Then I can see who has downloaded ACAS certificate 'CertificateFound'