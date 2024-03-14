module EtFullSystem
  module Test
    class Base < ::SitePrism::Page
      def initialize(mail, locale: nil)
        self.mail = mail
        self.locale = locale
        multipart = mail.parts.detect { |p| p.content_type =~ %r{multipart\/alternative} }
        part = (multipart || mail).parts.detect { |p| p.content_type =~ %r{text\/html} }
        body = part.nil? ? '' : part.body.to_s
        @page = Capybara.string(body)
      end

      private

      attr_accessor :mail, :page, :locale
  end
  end
end
