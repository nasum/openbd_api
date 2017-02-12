module OpenBD
  module Responses
    class Get < BaseResponse
      include ::Enumerable

      def each(&block)
        resources.each(&block)
      end

      def resources
        body.map do |source|
          ::OpenBD::Resources::OpenbdItem.new(source)
        end
      end
    end
  end
end
