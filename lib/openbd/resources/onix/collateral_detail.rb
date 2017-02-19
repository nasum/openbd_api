module OpenBD
  module Resources
    class Onix

      ##
      # Block 2: Marketing collateral detail
      #
      # 商品の付帯項目について記述する。
      #
      class CollateralDetail < BaseResource

        # Short description/annotation (内容紹介1（取次広報誌（書店向）用）)
        attr_reader :short_description

        # Description (内容紹介2（読者／仕入参考用）)
        attr_reader :description

        # Table of Contents (目次)
        attr_reader :toc

        # Front cover (書影)
        attr_reader :cover

        # Product image / Artwork (付録、商品イメージ)
        attr_reader :image

        def initialize(source)
          super
          @short_description = nil
          @description = nil
          @toc = nil
          @cover = []
          @image = []
          parse(source)
        end

        def parse(cd)
          if cd["TextContent"]
            cd["TextContent"].each do |text|

              # ONIX Code Lists: List 153: Text type
              # https://onix-codelists.io/codelist/153
              case text["TextType"]
              when "02" ## Short Description/annotation
                @short_description = text["Text"]
              when "03" ## Description
                @description = text["Text"]
              when "04" ## TableOfContents
                @toc = text["Text"]
              end
            end
          end

          if cd["SupportingResource"] # 書影や付録などの画像ファイル
            cover = []
            image = []
            # 画像ファイルは3つまで指定可能
            cd["SupportingResource"].each do |sr|

              # Onix codelists List 158: Resource content type
              # https://onix-codelists.io/codelist/158
              if sr["ResourceContentType"] == "01" # Front cover
                cover.push(sr["ResourceVersion"][0]["ResourceLink"])
              end
              if sr["ResourceContentType"] == "07" # Product image / artwork
                image.push(sr["ResourceVersion"][0]["ResourceLink"])
              end
            end
            if cover.length > 0
              @cover = cover
            end
            if image.length > 0
              @image = image
            end
          end
        end
      end
    end
  end
end
