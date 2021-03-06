module OpenBD
  module Resources
    class Onix

      ##
      # Authorship (Contributor)
      #
      # This class is used in DescriptiveDetail as Contributor
      #
      class Contributor < BaseResource

        # Contributor's Role (著者区分)
        # @return [Array<String>]
        attr_reader :role

        # Contributor's Name (著者名)
        attr_reader :name

        # Collationkey of Contributor's Name (著者名読み)
        attr_reader :name_colationkey

        # Sequence number of Contributor (著者順序)
        # @return [String]
        attr_reader :seqence_number

        # Biographical Note (著者略歴)
        attr_reader :biographical_note

        def initialize(src)
          super
          @role = src["ContributorRole"]
          @name = src["PersonName"]["content"] rescue nil
          @name_collationkey = src["PersonName"]["collationkey"] rescue nil
          @seqence_number = src["SequenceNumber"]
          @biographical_note = src["BiographicalNote"]
        end
      end
    end
  end
end
