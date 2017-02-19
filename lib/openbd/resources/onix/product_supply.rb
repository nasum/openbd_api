module OpenBD
  module Resources
    class Onix

      ##
      # Block 6: Product supply
      #
      # 市場における商品の出版状況、供給等について記述する。
      #
      class ProductSupply < BaseResource

        # Returns conditions (販売条件)
        #
        # Onix codelists, List 204: ONIX Returns conditions code
        # https://onix-codelists.io/codelist/204
        attr_reader :returns_conditions_code

        # Price Excluding Tax, JPY (希望小売価格, 定価)
        attr_reader :price

        # Special Price Excluding Tax, JPY (特価)
        attr_reader :special_price

        # Special Price From Date (特価開始日)
        attr_reader :special_price_from_date

        # Special Price Until Date (特価終了日)
        attr_reader :special_price_until_date

        def initialize(source)
          super
          @returns_conditions_code = nil
          @price = nil
          @special_price = nil
          @special_price_from_date = nil
          @special_price_until_date = nil
          parse(source)
        end

        def parse(ps)
          if ps["SupplyDetail"]
            if ps["SupplyDetail"]["ReturnsConditions"]
              @returns_conditions_code = ps["SupplyDetail"]["ReturnsConditions"]["ReturnsCode"]
            end
            if ps["SupplyDetail"]["Price"]
              ps["SupplyDetail"]["Price"].each do |pr|
                price = price_mode = nil

                # Onix codelists, List 58: Price type code
                # https://onix-codelists.io/codelist/58
                case pr["PriceType"]
                when "01", "03" ## RRP(Recommended Retail Price) Excluding Tax, Fixed Retail Price Excluding Tax
                  @price = pr["PriceAmount"]
                  price_mode = :normal
                when "11", "13" ## Special sale RRP excluding tax, Special sale fixed retail price excluding tax
                  @special_price = pr["PriceAmount"]
                  price_mode = :special
                else
                  next
                end
                if pr["PriceDate"]
                  pr["PriceDate"].each do |pdi|

                    # Onix codelists, List 173: Price date role
                    # https://onix-codelists.io/codelist/173
                    case pdi["PriceDateRole"]
                    when "14" ## FromDate
                      @special_price_from_date = pdi["Date"]
                    when "15" ## UntilDate
                      @special_price_until_date = pdi["Date"]
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end
