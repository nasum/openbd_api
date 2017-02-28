module OpenBD
  module Resources
    class Hanmoto

      # Review
      #
      # 書評
      class Review < BaseResource

        # 情報源
        def source
          src["source"]
        end

        # 朝刊・夕刊
        def choyukan
          src["choyukan"]
        end

        # 版
        def han
          src["han"]
        end

        # 情報源ID
        # @return [Integer]
        def source_id
          src["source_id"]
        end

        # 評者
        def reviewer
          src["reviewer"]
        end

        # 書評掲載日
        def appearance
          src["appearance"]
        end

        # 投稿ユーザー
        def post_user
          src["post_user"]
        end

        # リンク(URL)
        # @return [String]
        def link
          src["link"]
        end

        # 区分ID
        # @return [Integer]
        def kubun_id
          src["kubun_id"]
        end
      end
    end
  end
end
