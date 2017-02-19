module OpenBD
  module Resources
    class Onix

      ##
      # Block 1: Product description
      #
      class DescriptiveDetail < BaseResource

        # Product Composition (分売可否)
        attr_reader :product_composition
        alias_method :bunbai, :product_composition

        # Product Form Code
        attr_reader :product_form

        # Product Form Detail (判型)
        #
        # Onix codelists List 175: Product form detail
        # https://onix-codelists.io/codelist/175
        attr_reader :product_form_detail
        alias_method :hankei, :product_form_detail

        # Height (サイズ・タテ)
        # @return [String]
        attr_reader :height

        # Width (サイズ・ヨコ)
        # @return [String]
        attr_reader :width

        # Product Parts (付録)
        attr_reader :product_parts

        # Collection Sequence/Publication order (配本回数)
        attr_reader :collection_sequence

        # Number of Series (シリーズ巻次)
        # @return [String]
        attr_reader :series_num

        # Subcollection / Series (シリーズ名)
        attr_reader :series

        # Collationkey of Series (シリーズ読み)
        attr_reader :series_collationkey

        # Collection level / Label (レーベル)
        attr_reader :label

        # Collationkey of Label (レーベル読み)
        attr_reader :label_collationkey

        # Title (書名)
        attr_reader :title

        # Collationkey of Title (書名読み)
        attr_reader :title_collationkey

        # Subtitle (サブタイトル)
        attr_reader :subtitle

        # Collationkey of Subtitle (サブタイトル読み)
        attr_reader :subtitle_collationkey

        # Contributors / Authors (著者)
        # @return [Array<OpenBD::Resources::Onix::Contributor>]
        attr_reader :authors

        # Languages (言語設定)
        # @return [Array<String>]
        attr_reader :languages

        # Pages (ページ数)
        # @return [String]
        attr_reader :pages

        # Keywords (キーワード)
        # @return [String]
        attr_reader :subject_heading_text
        alias_method :keywords, :subject_heading_text

        # Japanese book trade C-Code (Cコード)
        # @return [String]
        attr_reader :ccode

        # Japanese book trade Genre Code (ジャンルコード)
        # @return [String]
        attr_reader :genre_code

        # Japanese Chidren's audience code (児童書読者コード)
        attr_reader :jp_childrens_audience_code

        # ONIX Adult audience rating (成人指定)
        # https://onix-codelists.io/codelist/203
        attr_reader :onix_adult_audience_rating

        def initialize(source)
          super
          @product_composition = nil
          @product_form = nil
          @product_form_detail = nil
          @height = nil
          @width = nil
          @product_parts = nil
          @collection_sequence = nil
          @series_number = nil
          @series = nil
          @series_collationkey = nil
          @label = nil
          @label_collationkey = nil
          @title = nil
          @title_collationkey = nil
          @subtitle = nil
          @subtitle_collationkey = nil
          @authors = []
          @languages = []
          @pages = nil
          @subject_heading_text = nil
          @ccode = nil
          @genre_code = nil
          @jp_childrens_audience_code = nil
          @onix_adult_audience_rating = nil
          parse(source)
        end

        def parse(dd)
          @product_composition = dd["ProductComposition"]

          # Onix codelists, List 150: Product form
          # https://onix-codelists.io/codelist/150
          # Value: "BA" (Book), "BZ" (Other book format) or "ZA" (General merchandise, not recommended)
          @product_form = dd["ProductForm"]
          if @product_form == "BA"

            # Onix codelists List 175: Product form detail
            # https://onix-codelists.io/codelist/175
            @product_form_detail = dd["ProductFormDetail"]
          end

          if dd["Measure"]
            dd["Measure"].each do |m|

              # Onix codelists, List 48: Measure type code
              # https://onix-codelists.io/codelist/48
              case m["MeasureType"]
              when "01"
                @height = m["Measurement"] + m["MeasureUnitCode"]
              when "02"
                @width = m["Measurement"] + m["MeasureUnitCode"]
              else
                nil
              end
            end
          end

          if dd["ProductPart"]
            @product_parts = dd["ProductPart"].map do |part|
              part["ProductFormDescription"]
            end
          end

          if dd["Collection"]
            if dd["Collection"]["CollectionSequence"]
              @collection_sequence = dd["Collection"]["CollectionSequence"]["CollectionSequenceNumber"]
            end
            if dd["Collection"]["TitleDetail"] && dd["Collection"]["TitleDetail"]["TitleElement"]

              # Onix codelists, List 149: Title element level
              # https://onix-codelists.io/codelist/149
              dd["Collection"]["TitleDetail"]["TitleElement"].each do |te|
                if te["TitleElementLevel"] == "03" ## Subcollection
                  if te["PartNumber"]
                    @series_number = te["PartNumber"]
                  end
                  @series = te["TitleText"]["content"]
                  @series_collationkey = te["TitleText"]["collationkey"]
                elsif te["TitleElementLevel"] == "02" ## Collection level
                  @label = te["TitleText"]["content"]
                  @label_collationkey = te["TitleText"]["collationkey"]
                end
              end
            end
          end

          if dd["TitleDetail"]
            @title = dd["TitleDetail"]["TitleElement"]["TitleText"]["content"]
            @title_collationkey = dd["TitleDetail"]["TitleElement"]["TitleText"]["collationkey"]
            if dd["TitleDetail"]["TitleElement"]["Subtitle"]
              @subtitle = dd["TitleDetail"]["TitleElement"]["Subtitle"]["content"]
              @subtitle_collationkey = dd["TitleDetail"]["TitleElement"]["Subtitle"]["collationkey"]
            end
          end

          if dd["Contributor"]
            @authors = dd["Contributor"].map do |author|
              OpenBD::Resources::Onix::Contributor.new(author)
            end
          end

          if dd["Language"]
            @languages = dd["Language"].map{|lang| lang["LanguageCode"]}
          end

          if dd["Extent"] && dd["Extent"][0]
            @pages = dd["Extent"][0]["ExtentValue"]
          end

          if dd["Subject"]
            dd["Subject"].each do |sbj|

              # Onix codelists, List 27: Subject scheme identifier code
              # https://onix-codelists.io/codelist/27
              case sbj["SubjectSchemeIdentifier"]
              when "20"
                @subject_heading_text = sbj["SubjectHeadingText"] ## keywords
              when "78"
                @ccode = sbj["SubjectCode"]
              when "79"
                @genre_code = sbj["SubjectCode"]
              end
            end
          end

          # ONIX Code Lists, List 29: Audience code type
          #  https://onix-codelists.io/codelist/29
          if dd["Audience"]
            dd["Audience"].each do |aud|
              if aud["AudienceCodeType"] == "21" ## JapaneseChildrensAudienceCode
                @jp_childrens_audience_code = aud["AudienceCodeValue"]
              elsif aud["AudienceCodeType"] == "22" ## OnixAdultAudienceRating
                @onix_adult_audience_rating = aud["AudienceCodeValue"]
              end
            end
          end
        end
      end
    end
  end
end
