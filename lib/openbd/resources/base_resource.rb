module OpenBD
  module Resources
    class BaseResource
      attr_reader :source

      def initialize(source)
        @source = source
      end
    end
  end
end
