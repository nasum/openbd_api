module OpenBD
  module Responses
    class Coverage < BaseResponse
      include ::Enumerable

      def each(&block)
        body.each(&block)
      end

      def size
        body.size
      end
    end
  end
end
