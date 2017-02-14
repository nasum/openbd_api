module OpenBD
  module Resources
    class OpenbdItem < BaseResource
      def initialize(source)
        @source = source
        @hanmoto = nil
        @onix = nil
        @summary = nil
      end

      def onix
        @onix ||= ::OpenBD::Resources::Onix.new(source['onix'])
      end

      def hanmoto
        @hanmoto ||= ::OpenBD::Resources::Hanmoto.new(source['hanmoto'])
      end

      def summary
        @summary ||= ::OpenBD::Resources::Summary.new(source['summary'])
      end
    end
  end
end
