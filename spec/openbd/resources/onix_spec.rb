require "spec_helper"
require "json"

RSpec.describe OpenBD::Resources::Onix do
  let(:sample_onix_data) do
    <<-'EOB'
{"CollateralDetail": {"SupportingResource": [{"ResourceContentType": "01", "ResourceMode": "03", "ContentAudience": "01", "ResourceVersion": [{"ResourceLink": "https://cover.openbd.jp/9784797386295.jpg", "ResourceForm": "02", "ResourceVersionFeature": [{"ResourceVersionFeatureType": "01", "FeatureValue": "D502"}, {"ResourceVersionFeatureType": "04", "FeatureValue": "9784797386295.jpg"}]}]}], "TextContent": [{"Text": "Ruby入門書の超ロングセラー！", "TextType": "02", "ContentAudience": "00"}, {"Text": "いちばん売れているRuby入門書の決定版。\n\n初版から14年。改訂とともに変化しながら、ずっと読まれ続けている定番書です。\n第5版では、最新のバージョンに対応。\n\nプログラミング初心者でも読み解けるように、\nチュートリアル、基礎、クラス、実践とテーマを切り分けて、平易に解説。\nRubyの基礎から応用までがわかる一冊。\n\n", "TextType": "03", "ContentAudience": "00"}, {"Text": "第1部 Rubyをはじめよう\n第2部 基礎を学ぼう\n第3部 クラスを使おう\n第4部 ツールを作ってみよう\n", "TextType": "04", "ContentAudience": "00"}]}, "PublishingDetail": {"Imprint": {"ImprintName": "SBクリエイティブ", "ImprintIdentifier": [{"IDValue": "7973", "ImprintIDType": "19"}, {"IDValue": "4199", "ImprintIDType": "24"}]}, "PublishingDate": [{"Date": "20160227", "PublishingDateRole": "01"}]}, "ProductSupply": {"SupplyDetail": {"ReturnsConditions": {"ReturnsCode": "03", "ReturnsCodeType": "04"}, "ProductAvailability": "99", "Price": [{"PriceAmount": "2600", "CurrencyCode": "JPY", "PriceType": "03"}]}}, "NotificationType": "03", "ProductIdentifier": {"IDValue": "9784797386295", "ProductIDType": "15"}, "RecordReference": "9784797386295", "DescriptiveDetail": {"TitleDetail": {"TitleType": "01", "TitleElement": {"TitleElementLevel": "01", "TitleText": {"content": "たのしいRuby 第5版", "collationkey": "タノシイルビー ダイゴハン"}}}, "Language": [{"LanguageCode": "jpn", "LanguageRole": "01"}], "ProductForm": "BA", "Audience": [{"AudienceCodeType": "22", "AudienceCodeValue": "00"}], "Extent": [{"ExtentValue": "520", "ExtentUnit": "03", "ExtentType": "11"}], "Contributor": [{"ContributorRole": ["A01"], "PersonName": {"content": "高橋 征義", "collationkey": "タカハシ マサヨシ"}, "BiographicalNote": "札幌出身。北海道大学卒。Webアプリケーションの開発に従事する傍ら、日本Rubyの会を設立し、 以降現在まで同会代表をつとめる。2010年からは株式会社達人出版会にて電子出版事業に注力中。 著書に『たのしいRuby』『Rails3レシピブック 190の技』(共著)など。 好きなメソッドはattr_accessor。 好きな作家は新井素子。", "SequenceNumber": "1"}, {"ContributorRole": ["A01"], "PersonName": {"content": "後藤 裕蔵", "collationkey": "ゴトウ ユウゾウ"}, "BiographicalNote": "福岡県出身。九州工業大学卒。 株式会社ネットワーク応用通信研究所取締役。 1999年、jusによるイベント「Rubyワークショップ」でRubyと出会う。 以来、Rubyに関する雑誌記事の執筆や標準添付ライブラリのwebrickおよびopensslのメンテナとしてもRubyに関わる。 好きなメソッドはEnumerable#inject。好きなロックバンドはピンクフロイド。", "SequenceNumber": "2"}, {"ContributorRole": ["B20"], "PersonName": {"content": "まつもと ゆきひろ", "collationkey": "マツモト ユキヒロ"}, "SequenceNumber": "3"}], "Subject": [{"SubjectSchemeIdentifier": "78", "SubjectCode": "0055"}, {"SubjectSchemeIdentifier": "79", "SubjectCode": "20"}, {"SubjectSchemeIdentifier": "20", "SubjectHeadingText": "プログラミング;Ruby;まつもとゆきひろ;高橋メソッド;Python;スクリプト言語;オブジェクト指向;;イテレーター;ハッシュ;メソッド"}], "ProductFormDetail": "B108", "ProductComposition": "00"}}
    EOB
  end
  let(:onix_item) do
    json = JSON.parse(sample_onix_data)
    OpenBD::Resources::Onix.new(json)
  end

  describe "#record_reference" do
    it "has an ISBN as RecordReference" do
      expect(onix_item.record_reference).to be == "9784797386295"
    end

    it "has an ISBN as isbn" do
      expect(onix_item.isbn).to be == "9784797386295"
    end
  end

  describe "#descriptive_detail" do
    it "has a title andd its collationkey" do
      expect(onix_item.descriptive_detail.title).to be == "たのしいRuby 第5版"
      expect(onix_item.descriptive_detail.title_collationkey).to be == "タノシイルビー ダイゴハン"
    end

    it "has pages" do
      expect(onix_item.descriptive_detail.pages).to be == "520"
    end

    it "has languages" do
      expect(onix_item.descriptive_detail.languages).to be == ["jpn"]
    end

    it "has authors" do
      onix_item.descriptive_detail.authors.each do |author|
        case author.seqence_number
        when "1"
          expect(author.name).to be == "高橋 征義"
          expect(author.role).to be == ["A01"]
        when "2"
          expect(author.name).to be == "後藤 裕蔵"
          expect(author.role).to be == ["A01"]
        when "3"
          expect(author.name).to be == "まつもと ゆきひろ"
          expect(author.role).to be == ["B20"]
        end
      end
    end
  end

  describe "#collateral_detail" do
    it "has ToC" do
      expect(onix_item.collateral_detail.toc).to be == "第1部 Rubyをはじめよう\n第2部 基礎を学ぼう\n第3部 クラスを使おう\n第4部 ツールを作ってみよう\n"
    end

    it "has a URL of cover" do
      expect(onix_item.collateral_detail.cover[0]).to be == "https://cover.openbd.jp/9784797386295.jpg"
    end
  end

  describe "#publishing_detail" do
    it "has an imprint" do
      imprint = onix_item.publishing_detail.imprint
      expect(imprint.name).to be == "SBクリエイティブ"
      expect(imprint.publisher_id).to be == "7973"
    end

    it "has a publishing date" do
      expect(onix_item.publishing_detail.publishing_date).to be == "20160227"
    end
  end

  describe "#product_supply" do
    it "has a price" do
      expect(onix_item.product_supply.price).to be == "2600"
    end
  end
end
