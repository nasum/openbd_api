module OpenBD
  module Responses
    class BaseResponse
      def initialize(faraday_response)
        @faraday_response = faraday_response
      end

      def body
        @faraday_response.body
      end
    end
  end
end
