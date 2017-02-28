module OpenBD
  module Resources
    class OpenbdItem < BaseResource
      def initialize(src)
        @src = src
        @hanmoto = nil
        @onix = nil
        @summary = nil
      end

      def onix
        @onix ||= ::OpenBD::Resources::Onix.new(src['onix'])
      end

      def hanmoto
        @hanmoto ||= ::OpenBD::Resources::Hanmoto.new(src['hanmoto'])
      end

      def summary
        @summary ||= ::OpenBD::Resources::Summary.new(src['summary'])
      end
    end
  end
end
