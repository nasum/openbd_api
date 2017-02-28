module OpenBD
  module Resources

    # 版元独自書誌
    class Hanmoto < BaseResource

      def initialize(src)
        super
        @jyuhan = nil
        @reviews = nil
      end

      def dateshuppan
        src["dateshuppan"]
      end

      # 類書・競合書
      def ruishokyougousho
        src["ruishokyougousho"]
      end

      # 重版情報
      def jyuhan
        @jyuhan if @jyuhan
        if src["jyuhan"]
          @jyuhan = src["jyuhan"].map{|item| OpenBD::Resources::Hanmoto::Jyuhan.new(item) }
        end
        @jyuhan
      end

      # 帯の内容
      def obinaiyou
        src["obinaiyou"]
      end

      # TRC用備考
      def bikoutrc
        src["bikoutrc"]
      end

      # 雑誌コード
      def zasshicode
        src["zasshicode"]
      end

      # TRC用児童ジャンルコード
      def genrecodetrcjidou
        src["genrecodetrcjidou"]
      end

      # 別称資料?
      def bessoushiryou
        src["bessoushiryou"]
      end

      # 関連書ISBN
      def kanrenshoisbn
        src["kanrenshoisbn"]
      end

      # 試し読みフラグ
      # @return [boolean]
      def hastameshiyomi
        src["hastameshiyomi"]
      end

      # NDC(日本十進分類法)
      def ndccode
        src["ndccode"]
      end

      # 原書名
      def genshomei
        src["genshomei"]
      end

      # 105文字程度の解説
      def kaisetsu105w
        src["kaisetsu105w"]
      end

      # 追記
      def tsuiki
        src["tsuiki"]
      end

      # 受賞情報
      def jushoujouhou
        src["jushoujouhou"]
      end

      # 付録その他
      def furokusonota
        src["furokusonota"]
      end

      # 販売区分
      # @return [Boolean]
      def kubunhanbai
        src["kubunhanbai"]
      end

      # 付録コード
      # @return [Integer]
      def furoku
        src["furoku"]
      end

      # 最終更新日
      def datemodified
        src["datemodified"]
      end

      # 読者書き込み
      def dokushakakikomi
        src["dokushakakikomi"]
      end

      # 在庫ステータス
      # @return [Integer]
      def zaiko
        src["zaiko"]
      end

      # ルビの有無
      # @return [Boolean]
      def rubynoumu
        src["rubynoumu"]
      end

      # 読者書き込みページ数
      # @return [Integer]
      def dokushakakikomipagesuu
        src["dokushakakikomipagesuu"]
      end

      # 版
      # @return [String]
      def han
        src["han"]
      end

      # 月号・号数
      # @return [String]
      def gatsugougousuu
        src["gatsugougousuu"]
      end

      # 版元からひとこと
      def hanmotokarahitokoto
        src["hanmotokarahitokoto"]
      end

      # 重版予定日
      def datejuuhanyotei
        src["datejuuhanyotei"]
      end

      # 著者補足情報
      # @return [Array<Hash>]
      def author
        src["author"]
      end

      # その他の特記事項
      def sonotatokkijikou
        src["sonotatokkijikou"]
      end

      # 最終作成日
      def datecreated
        src["datecreated"]
      end

      # 書評情報
      # @return [Array<OpenBD::Resources::Hanmoto::Review>]
      def reviews
        @reviews if @reviews
        if src["reviews"]
          @reviews = src["reviews"].map{|item| OpenBD::Resources::Hanmoto::Review.new(item)}
        end
        @reviews
      end

      # TRC用ジャンルコード
      def genrecodetrc
        src["genrecodetrc"]
      end

      # 本の綴じ方
      def toji
        src["toji"]
      end

      # ラノベフラグ
      def lanove
        src["lanove"]
      end

      # 関連書
      def kanrensho
        src["kanrensho"]
      end

      # 絶版日
      def datezeppan
        src["datezeppan"]
      end

      # 刊行形態
      def kankoukeitai
        src["kankoukeitai"]
      end

      # まえがきなど
      def maegakinado
        src["maegakinado"]
      end
    end
  end
end
