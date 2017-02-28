module OpenBD
  module Resources
    class Onix

      ##
      # Block 4: Publishing detail
      #
      # 出版社に関する情報を記述する。
      #
      class PublishingDetail < BaseResource

        # Imprint (発行出版社)
        # @return [OpenBD::Resources::Onix::Publisher]
        attr_reader :imprint

        # Publisher (発売出版社)
        # @return [OpenBD::Resources::Onix::Publisher]
        attr_reader :publisher

        # Publishing Date (発売予定日)
        # @return [String]
        attr_reader :publishing_date

        # Publishing Embargo Date (発売協定日)
        # @return [String]
        attr_reader :publishing_embargo_date

        # Public Announcement Date (発売情報解禁日)
        # @return [String]
        attr_reader :public_announcement_date

        # Publishers Reservation Order Deadline (注文・申込締切（事前予約注文締切日）)
        # @return [String]
        attr_reader :publishers_reservation_order_deadline

        def initialize(src)
          super
          @imprint = nil
          @publisher = nil
          @publishing_date = nil
          @publishing_embargo_date = nil
          @public_announcement_date = nil
          @publishers_reservation_order_deadline = nil
          parse(src)
        end

        def parse(pd)
          if pd["Imprint"]
            publisher_id = distribution_id = nil
            pd["Imprint"]["ImprintIdentifier"].each do |ii|

              # Onix codelists, List 44: Name code type
              # https://onix-codelists.io/codelist/44
              case ii["ImprintIDType"]
              when "19" ## JapanesePublisherIdentifier, 発行出版社コード
                publisher_id = ii["IDValue"]
              when "24" ## JpDistributionIdentifier, 発行取引コード
                distribution_id = ii["IDValue"]
              end
            end
            name = pd["Imprint"]["ImprintName"] ## 発行出版社名
            @imprint = OpenBD::Resources::Onix::Publisher.new(name,
                                                              publisher_id,
                                                              distribution_id)
          end

          if pd["Publisher"]
            publisher_id = distribution_id = nil
            pd["Publisher"]["PublisherIdentifier"].each do |pi|

              # Onix codelists, List 44: Name code type
              # https://onix-codelists.io/codelist/44
              case pi["PublisherIDType"]
              when "19" ## JapanesePublisherIdentifier, 発売出版社コード
                publisher_id = pi["IDValue"]
              when "24" ## JpDistributionIdentifier, 発売取引コード
                distribution_id = pi["IDValue"]
              end
            end
            name = pd["Publisher"]["PublisherName"] ## 発売出版社名
            @publisher = OpenBD::Resources::Onix::Publisher.new(name,
                                                                publisher_id,
                                                                distribution_id)
          end

          if pd["PublishingDate"]
            pd["PublishingDate"].each do |pdi|

              # Onix Codelists, List 163: Publishing date role
              # https://onix-codelists.io/codelist/163
              case pdi["PublishingDateRole"]
              when "01" ## PublicationDate
                @publishing_date = pdi["Date"]
              when "02" ## EmbargoDate
                @publishing_embargo_date = pdi["Date"]
              when "09" ## PublicAnnouncementDate
                @public_announcement_date = pdi["Date"]
              when "25" ## PublishersReservationOrderDeadline
                @publishers_reservation_order_deadline = pdi["Date"]
              end
            end
          end
        end
      end
    end
  end
end
