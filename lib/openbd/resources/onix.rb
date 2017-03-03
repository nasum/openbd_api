module OpenBD
  module Resources

    ##
    # Bibliographic Information of JPRO-onix specification (based ONIX for Books 3.0.x)
    # http://www.editeur.org/83/Overview/
    # https://jpro.jpo.or.jp/
    #
    # 出版情報登録センター「データ仕様　第3版」（ONIX for Books 3.0.x準拠）
    # http://www.jpo.or.jp/topics/data/20160113a_jpoinfo.pdf
    #
    class Onix < BaseResource

      attr_reader :record_reference ## ISBN
      attr_reader :descriptive_detail
      attr_reader :collateral_detail
      attr_reader :publishing_detail
      attr_reader :product_supply

      alias_method :isbn, :record_reference

      GENRE = {
        "01" => "文芸",
        "02" => "新書",
        "03" => "社会一般",
        "04" => "資格・試験",
        "05" => "ビジネス",
        "06" => "スポーツ・健康",
        "07" => "趣味・実用",
        "09" => "ゲーム",
        "10" => "芸能・タレント",
        "11" => "テレビ・映画化",
        "12" => "芸術",
        "13" => "哲学・宗教",
        "14" => "歴史・地理",
        "15" => "社会科学",
        "16" => "教育",
        "17" => "自然科学",
        "18" => "医学",
        "19" => "工業・工学",
        "20" => "コンピュータ",
        "21" => "語学・辞事典",
        "22" => "学参",
        "23" => "児童図書",
        "24" => "ヤングアダルト",
        "29" => "新刊セット",
        "30" => "全集",
        "31" => "文庫",
        "36" => "コミック文庫",
        "41" => "コミックス(欠番扱)",
        "42" => "コミックス(雑誌扱)",
        "43" => "コミックス(書籍)",
        "44" => "コミックス(廉価版)",
        "51" => "ムック",
        "71" => "雑誌",
        "81" => "増刊",
        "86" => "別冊"
      }

      CONTRIBUTOR_ROLE = {
        "A01" => "著",
        "B01" => "編",
        "B20" => "監修",
        "B06" => "翻訳",
        "A12" => "画、イラスト",
        "A08" => "写真",
        "A38" => "原作",
        "A10" => "原案",
        "A21" => "解説",
        "E07" => "朗読",
      }

      FORMAT = {
        "B108" => "A5",
        "B109" => "B5",
        "B110" => "B6",
        "B111" => "文庫",
        "B112" => "新書",
        "B119" => "46",
        "B120" => "46変形",
        "B121" => "A4",
        "B122" => "A4変形",
        "B123" => "A5変形",
        "B124" => "B5変形",
        "B125" => "B6変形",
        "B126" => "AB",
        "B127" => "B7",
        "B128" => "菊",
        "B129" => "菊変形",
        "B130" => "B4",
      }

      JP_CHILDRENS_AUDIENCE_CODE = {
        "01" => "0～2歳",
        "02" => "3～5歳",
        "03" => "小学低学年",
        "04" => "小学中学年",
        "05" => "小学高学年",
        "06" => "小学全般",
        "07" => "中学以上",
        "08" => "高校",
      }

      ONIX_ADULT_AUDIENCE_RATING = {
        "00" => "指定なし",
        "01" => "成人指定（理由明記なし）",
        "02" => "成人向け",
        "03" => "成人向け（性）",
        "04" => "成人向け（暴力）",
        "05" => "成人向け（薬物）",
        "06" => "成人向け（言語）",
      }

      def initialize(src)
        super
        @record_reference = src["RecordReference"] ## ISBN
        @descriptive_detail = nil
        @collateral_detail = nil
        @publishing_detail = nil
        @product_supply = nil
      end

      def descriptive_detail
        @descriptive_detail ||= OpenBD::Resources::Onix::DescriptiveDetail.new(src["DescriptiveDetail"])
      end

      def collateral_detail
        @collateral_detail ||= OpenBD::Resources::Onix::CollateralDetail.new(src["CollateralDetail"])
      end

      def publishing_detail
        @publishing_detail ||= OpenBD::Resources::Onix::PublishingDetail.new(src["PublishingDetail"])
      end

      def product_supply
        @product_supply ||= OpenBD::Resources::Onix::ProductSupply.new(src["ProductSupply"])
      end
    end
  end
end
