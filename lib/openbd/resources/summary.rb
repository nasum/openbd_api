module OpenBD
  module Resources
    class Summary < BaseResource
      def isbn
        source['isbn']
      end

      def title
        source['title']
      end

      def volume
        source['volume']
      end

      def series
        source['series']
      end

      def publisher
        source['publisher']
      end

      def pubdate
        source['pubdate']
      end

      def cover
        source['cover']
      end

      def author
        source['author']
      end
    end
  end
end
