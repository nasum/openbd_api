require "spec_helper"

RSpec.describe OpenBD::Client do
  let(:client){ OpenBD::Client.new }
  let(:sample_book_data) do
    <<-EOB
[{"onix": {"CollateralDetail": {"SupportingResource": [{"ResourceContentType": "01", "ResourceMode": "03", "ContentAudience": "01", "ResourceVersion": [{"ResourceLink": "https://cover.openbd.jp/9784797336610.jpg", "ResourceForm": "02", "ResourceVersionFeature": [{"ResourceVersionFeatureType": "01", "FeatureValue": "D502"}, {"ResourceVersionFeatureType": "04", "FeatureValue": "9784797336610.jpg"}]}]}], "TextContent": [{"Text": "第1部 Rubyをはじめよう(はじめてのRuby\n便利なオブジェクト ほか)\n第2部 基礎を学ぼう(オブジェクトと変数・定数\n条件判断 ほか)\n第3部 クラスを学ぼう(数値(Numeric)クラス\n配列(Array)クラス ほか)\n第4部 Rubyを使いこなそう(Ruby落ち穂ひろい\n演算子 ほか)\n第5部 ツールを作ってみよう(ログの解析\n郵便番号の検索 ほか)", "TextType": "04", "ContentAudience": "00"}]}, "PublishingDetail": {"Imprint": {"ImprintName": "ソフトバンククリエイティブ", "ImprintIdentifier": [{"ImprintIDType": "19"}]}, "PublishingDate": [{"Date": "", "PublishingDateRole": "01"}]}, "ProductSupply": {"SupplyDetail": {"ReturnsConditions": {"ReturnsCode": "02", "ReturnsCodeType": "04"}, "ProductAvailability": "99"}}, "NotificationType": "03", "ProductIdentifier": {"IDValue": "9784797336610", "ProductIDType": "15"}, "RecordReference": "9784797336610", "DescriptiveDetail": {"TitleDetail": {"TitleType": "01", "TitleElement": {"TitleText": {"content": "たのしいRuby : Rubyではじめる気軽なプログラミング", "collationkey": "タノシイ Ruby : Ruby デ ハジメル キガルナ プログラミング"}, "TitleElementLevel": "01"}}, "Language": [{"LanguageCode": "jpn", "LanguageRole": "01", "CountryCode": "JP"}], "ProductForm": "BZ", "Extent": [{"ExtentValue": "489", "ExtentUnit": "03", "ExtentType": "11"}], "Measure": [{"MeasureType": "01", "MeasureUnitCode": "mm", "Measurement": "210"}, {"MeasureType": "02", "MeasureUnitCode": "mm", "Measurement": "0"}], "Contributor": [{"ContributorRole": ["B20"], "PersonName": {"content": "まつもと ゆきひろ"}, "SequenceNumber": "1"}, {"ContributorRole": ["A01"], "PersonName": {"content": "後藤 裕蔵"}, "SequenceNumber": "2"}, {"ContributorRole": ["A01"], "PersonName": {"content": "高橋 征義"}, "SequenceNumber": "3"}], "ProductComposition": "00"}}, "hanmoto": {"dateshuppan": "2006-08", "datecreated": "2015-11-26 22:40:17", "datemodified": "2015-11-26 22:40:17"}, "summary": {"isbn": "9784797336610", "title": "たのしいRuby : Rubyではじめる気軽なプログラミング", "volume": "", "series": "", "publisher": "ソフトバンククリエイティブ", "pubdate": "2006-08", "cover": "https://cover.openbd.jp/9784797336610.jpg", "author": "まつもとゆきひろ／監修 後藤裕蔵／著 高橋征義／著"}}]
    EOB
  end

  describe "#normalize_isbns" do
    it "should normalize ISBN as String" do
      expect(client.normalize_isbns("9784780801118")).to be == "9784780801118"
    end

    it "should normalize ISBN as Integer" do
      expect(client.normalize_isbns(9784780801118)).to be == "9784780801118"
    end

    it "should normalize ISBNs as Array of String" do
      expect(client.normalize_isbns(["9784780801118", "9784939015809"])).to be == "9784780801118,9784939015809"
    end

    it "should normalize ISBNs as Array of Integer" do
      expect(client.normalize_isbns([9784780801118, 9784939015809])).to be == "9784780801118,9784939015809"
    end
  end

  describe "#get" do
    let!(:stub_connection) do
      Faraday.new do |conn|
        conn.adapter :test, Faraday::Adapter::Test::Stubs.new do |stub|
          stub.get("/v1/get?isbn=9784797336610") do
            [200, {}, sample_book_data]
          end
        end
      end
    end

    before do
      allow(client).to receive(:connection).and_return(stub_connection)
    end

    it "return a JSON of bookdata" do
      res = client.get "9784797336610"
      expect(res).to be_kind_of OpenBD::Responses::Get
      expect(res.body).to be == sample_book_data
    end
  end

  describe "#bulk_get" do
    let!(:stub_connection) do
      Faraday.new do |conn|
        conn.adapter :test, Faraday::Adapter::Test::Stubs.new do |stub|
          stub.get("/v1/get?isbn=9784797336610") do
            [200, {}, sample_book_data]
          end
        end
      end
    end

    before do
      allow(client).to receive(:connection).and_return(stub_connection)
    end

    it "return a JSON of bookdata" do
      res = client.bulk_get "9784797336610"
      expect(res).to be_kind_of OpenBD::Responses::Get
      expect(res.body).to be == sample_book_data
    end
  end

  describe "#coverage" do
    let(:coverages){ %w(9780001971714 9780002112925 9780002151764 9780002151900 9780002160322) } ## only top 5 items
    let!(:stub_connection) do
      Faraday.new do |conn|
        conn.adapter :test, Faraday::Adapter::Test::Stubs.new do |stub|
          stub.get("/v1/coverage") do
            [200, {}, coverages]
          end
        end
      end
    end

    before do
      allow(client).to receive(:connection).and_return(stub_connection)
    end

    it "return an Array of ISBNs" do
      res = client.coverage
      expect(res).to be_kind_of OpenBD::Responses::Coverage
      expect(res.body).to be == coverages
    end
  end
end
