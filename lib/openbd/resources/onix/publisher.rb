module OpenBD
  module Resources
    class Onix

      ##
      # Publisher / Imprint
      #
      # This class is used in PublishingDetail
      #
      class Publisher

        # Publisher Name (出版社名)
        attr_reader :name

        #  Japanese Publisher identifier (ISBN出版者記号)
        attr_reader :publisher_id

        # JP Distribution Identifier (取引コード)
        attr_reader :distribution_id

        def initialize(name, publisher_id, distribution_id)
          @name = name
          @publisher_id = publisher_id
          @distribution_id = distribution_id
        end
      end
    end
  end
end
