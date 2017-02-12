module OpenBD
  module Resources
    class OpenbdItem < BaseResource
      def initialize(source)
        @source = source
        @hanmoto = ::OpenBD::Resources::Hanmoto.new(source['hanmoto'])
        @onix = ::OpenBD::Resources::Onix.new(source['onix'])
        @summary = ::OpenBD::Resources::Summary.new(source['summary'])
      end

      def onix
        @onix
      end

      def hanmoto
        @hanmoto
      end

      def summary
        @summary
      end
    end
  end
end
