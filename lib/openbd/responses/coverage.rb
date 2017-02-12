module OpenBD
  module Responses
    class Coverage < BaseResponse
      include ::Enumerable

      def each(&block)
        body.each(&block)
      end
    end
  end
end
