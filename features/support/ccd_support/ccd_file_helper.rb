module EtFullSystem
  module Test
    module CcdFileHelper
      def download_file(response, file_type)
        document = response['case_fields']['documentCollection'].find do |document|
          document['value']['uploadedDocument']['document_filename'].end_with?(".#{file_type}")
        end

        url = document['value']['uploadedDocument']['document_binary_url']
        filename = document['value']['uploadedDocument']['document_filename']

        tempfile = Tempfile.new([File.basename(filename, ".*"), File.extname(filename)], File.absolute_path('../../../tmp', __dir__))
        File.open(tempfile, 'wb')  do |f|
          block = proc { |response|
            response.read_body do |chunk|
              f.write chunk
            end
          }
          RestClient::Request.new(method: :get, url: url, block_response: block).execute
        end
        tempfile
      end
    end
  end
end
