require "spec_helper"
require "json"

RSpec.describe OpenBD::Resources::OpenbdItem do
  let(:sample_book_data) do
    <<-'EOB'
{"onix":{"CollateralDetail":{"SupportingResource":[{"ResourceContentType":"01","ResourceMode":"03","ContentAudience":"01","ResourceVersion":[{"ResourceLink":"https://cover.openbd.jp/9784797357400.jpg","ResourceForm":"02","ResourceVersionFeature":[{"ResourceVersionFeatureType":"01","FeatureValue":"D502"},{"ResourceVersionFeatureType":"04","FeatureValue":"9784797357400.jpg"}]}]}],"TextContent":[{"Text":"第1部 Rubyをはじめよう(はじめてのRuby\n便利なオブジェクト ほか)\n第2部 基礎を学ぼう(オブジェクトと変数・定数\n条件判断 ほか)\n第3部 クラスを使おう(数値(Numeric)クラス\n配列(Array)クラス ほか)\n第4部 Rubyを使いこなそう(Ruby落ち穂ひろい\n演算子 ほか)\n第5部 ツールを作ってみよう(HTMLやRSSの解析\nHTTPサーバのアクセスログ解析)","TextType":"04","ContentAudience":"00"}]},"PublishingDetail":{"Imprint":{"ImprintName":"ソフトバンククリエイティブ","ImprintIdentifier":[{"IDValue":"7973","ImprintIDType":"19"}]},"PublishingDate":[{"Date":"","PublishingDateRole":"01"}]},"ProductSupply":{"SupplyDetail":{"ReturnsConditions":{"ReturnsCode":"02","ReturnsCodeType":"04"},"ProductAvailability":"99"}},"NotificationType":"03","ProductIdentifier":{"IDValue":"9784797357400","ProductIDType":"15"},"RecordReference":"9784797357400","DescriptiveDetail":{"TitleDetail":{"TitleType":"01","TitleElement":{"TitleText":{"content":"たのしいRuby","collationkey":"タノシイ Ruby"},"TitleElementLevel":"01"}},"Language":[{"LanguageCode":"jpn","LanguageRole":"01","CountryCode":"JP"}],"ProductForm":"BZ","Extent":[{"ExtentValue":"520","ExtentUnit":"03","ExtentType":"11"}],"Measure":[{"MeasureType":"01","MeasureUnitCode":"mm","Measurement":"210"},{"MeasureType":"02","MeasureUnitCode":"mm","Measurement":"0"}],"Contributor":[{"ContributorRole":["B20"],"PersonName":{"content":"まつもと ゆきひろ"},"SequenceNumber":"1"},{"ContributorRole":["A01"],"PersonName":{"content":"後藤 裕蔵"},"SequenceNumber":"2"},{"ContributorRole":["A01"],"PersonName":{"content":"高橋 征義"},"SequenceNumber":"3"}],"ProductComposition":"00"}},"hanmoto":{"dateshuppan":"2010-04","datecreated":"2016-01-26 20:34:10","datemodified":"2016-01-26 20:34:10"},"summary":{"isbn":"9784797357400","title":"たのしいRuby","volume":"","series":"","publisher":"ソフトバンククリエイティブ","pubdate":"2010-04","cover":"https://cover.openbd.jp/9784797357400.jpg","author":"まつもとゆきひろ／監修 後藤裕蔵／著 高橋征義／著"}}
    EOB
  end
  let(:item) do
    json = JSON.parse(sample_book_data)
    OpenBD::Resources::OpenbdItem.new(json)
  end

  describe "#onix" do
    it "has an ISBN in RecordReference" do
      expect(item.onix.src["RecordReference"]).to be == "9784797357400"
    end

    it "has a URL of cover" do
      expect(item.onix.src["CollateralDetail"]["SupportingResource"][0]["ResourceVersion"][0]["ResourceLink"]).to be == "https://cover.openbd.jp/9784797357400.jpg"
    end

      it "has a title" do
      expect(item.onix.src["DescriptiveDetail"]["TitleDetail"]["TitleElement"]["TitleText"]["content"]).to be == "たのしいRuby"
    end
end

  describe "#hanmoto" do
    it "has pubdate as dateshuppan" do
      expect(item.hanmoto.src["dateshuppan"]).to be == "2010-04"
    end
  end

  describe "#summary" do
    it "has pubdate" do
      expect(item.summary.src["pubdate"]).to be == "2010-04"
    end

    it "has an ISBN" do
      expect(item.summary.src["isbn"]).to be == "9784797357400"
    end

    it "has a title" do
      expect(item.summary.src["title"]).to be == "たのしいRuby"
    end
  end
end
