module OpenBD
  module Resources
    class BaseResource
      attr_reader :src

      def initialize(src)
        @src = src
      end
    end
  end
end
