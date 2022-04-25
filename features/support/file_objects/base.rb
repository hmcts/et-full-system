require_relative '../helpers/admin.rb'
module EtFullSystem
  module Test
    module FileObjects
      class Base
        include Admin
        def initialize(tempfile)
          self.tempfile = tempfile
        end

        private

        attr_accessor :tempfile

      end
    end
  end
end
