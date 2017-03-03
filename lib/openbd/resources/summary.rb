module OpenBD
  module Resources
    class Summary < BaseResource
      def isbn
        src['isbn']
      end

      def title
        src['title']
      end

      def volume
        src['volume']
      end

      def series
        src['series']
      end

      def publisher
        src['publisher']
      end

      def pubdate
        src['pubdate']
      end

      def cover
        src['cover']
      end

      def author
        src['author']
      end
    end
  end
end
