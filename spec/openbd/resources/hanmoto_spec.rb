require "spec_helper"
require "json"

RSpec.describe OpenBD::Resources::Hanmoto do
  let(:sample_hanmoto_data) do
    # 9784908736001.json
    <<-'EOB'
{"dateshuppan":"2016-06","ruishokyougousho":"広井良典『人口減少社会という希望』朝日選書，加藤久和『世代間格差：人口減少社会を問いなおす 』ちくま新書など，人口問題に関する書籍。心理学的な観点に立った書籍は本邦初。","ndccode":"140","toji":"並製","obinaiyou":"人口が減り始めた日本。\n私たちは命にどう関わるべきか？\n命についての問題―生殖補助医療，育児不安，母性，親子，介護，人生の終末―に直面し苦悩し，格闘する心を扱う「人口の心理学」の提案！\n心理学のみならず，人口学，社会学，生命倫理，日本近代史の第一線の論客が結集し，少子化，高齢化，人口減少に直面する日本社会のあり方を問う。","author":[{"listseq":1,"dokujikubun":"編"},{"listseq":2,"dokujikubun":"編"}],"datemodified":"2016-07-05 08:55:26","kaisetsu105w":"命についての問題―生殖補助医療，育児不安，母性，親子，介護，人生の終末―に直面し苦悩し，格闘する心を扱う人口の心理学の提案！今後の日本社会のあり方，そして自分たちの生き方を考える，刺激に満ちた1冊。","bikoutrc":"トランスビュー取り扱いです","genrecodetrc":4,"kankoukeitai":"BCD","maegakinado":"日本の人口現象―少子化，高齢化，人口減少―つまり，人間の生と死の問題が，私たちの命についての心とその表現としての行動とに深く関わっていることを明らかにしたいと，本書を企画しました。\n人口現象では人間の数（量）の変化に注目が集まりがちです。しかし，この量の変化に潜んでいる，あるいは，量の変化をもたらしている私たちの「命についての考え方」，つまり，質の変化こそが検討されるべきでしょう。人間がどのようにして生まれ，生まれた命をどのように扱い，どのように命を終えるかについての考え方に，革命的ともいえる重大な変化が起こっていることに注目するべきです。本書は，この変化の事実とそこに起こっている問題を明らかにし，さらに，新しい方向を見出すことを企図しています。","hanmotokarahitokoto":"発達心理学を長年にわたりリードしてきたお二人がタッグを組み，現代の日本が直面する人口に関する問題―少子，高齢，人口減少―が私たちの命や死，そして心の発達に何をもたらすのかを読み解いていきます。今後の日本社会のあり方，そして自分たちの生き方を考える，刺激に満ちた1冊です。","datecreated":"2016-05-30 08:23:25","bessoushiryou":"序章　人口の心理学の視点―命と死と生涯発達　●柏木惠子\n第Ⅰ部　誕生―「授かる命」から「つくる命」へ\n第1章　生殖補助医療・不妊治療のいま―心とテクノロジー　●小泉智恵・平山史朗\n第2章　産む選択、産まない選択―出生前診断　●玉井真理子\n第3章　近代日本社会と子どもの命―子返しの習俗と規範の形成　●太田素子\n第4章　血がつながらない子どもの親になる―特別養子縁組による親子の形　●富田庸子\n第Ⅱ部　親子関係―「少子の子ども」と「長命の親」\n第5章　子どもの価値―なぜ、女性は子どもを産むのか　●永久ひさ子\n第6章　育児不安を考える―ライフコースの激変とアイデンティティの揺らぎ　●柏木惠子・加藤邦子\n第7章　もたれ合う家族―日本の家族文化の問題　●舩橋惠子\n第8章　家族が変わる、老親介護も変わる―二一世紀の高齢者の介護と暮らし　●染谷俶子\n第Ⅲ部　命の終わり方―「長命」は「長寿」か\n第9章　人間の尊厳と死―「死の尊厳」の語られ方を読み解く　●大谷いづみ\n第10章　変わるお葬式、消えるお墓―その実態と現代人の意識　●小谷みどり\n第11章　長生きすること―長命の価値と課題　●森岡清美\n終章　少子高齢社会の命と心―現在とこれから　●高橋惠子\n\nコラム \n1　子どもの誕生と死の意味―先人の日記や手紙からの示唆　●柏木惠子\n2　将来の日本がもつ人口問題とは？　●別府志海\n3　日本の貧困　●阿部彩\n4　性・生殖と政治　●高橋惠子\n5　誕生のインファンティア　●西平直\n6　生殖補助医療の死角―当事者の視点から　●加藤英明\n7　「マタニティ・ハラスメント」は女性の身体性への差別　●杉浦浩美\n8　結婚、出産の価値の変化　●本田由紀\n9　なぜ少子に虐待か―家族臨床から見えること　●平木典子\n10　嬰児殺に見る命の重み　●川﨑二三彦\n11　「親孝行の終焉」の示唆するもの　●深谷昌志\n12　平均寿命と健康寿命　●菅原育子\n13　介護保険制度　●神前裕子\n14　江戸時代の高齢化と看取りのシステム　●柳谷慶子\n15　老人ホームに住むという選択　●神前裕子\n16　親孝行は美徳か？―親子間の資源の流れ再考　●柏木惠子\n17　長命化で厳しさを増す親と子のライフプラン　●畠中雅子","zaiko":11}
    EOB
  end

  let(:sample_hanmoto_data2) do
    # 9784863290006.json
    <<-'EOB'
{"dateshuppan":"2008-03","jyuhan":[{"date":"2016-06-23","comment":"とくに石垣が美しいことで有名な熊本城。本書はその姿をあえてモノクロームで表現しました。2016年4月の熊本地震で大きな被害をうけましたが、当時のうつくしく力強い姿をこれからに残すため、今回緊急増刷することにしました。","ctime":"2016-06-09 13:43:09","suri":3}],"author":[{"listseq":1,"dokujikubun":"編"}],"datemodified":"2011-03-19 11:43:10","zaiko":11}
    EOB
  end

  let(:sample_hanmoto_data3) do
    # 9784046215000.json
    <<-'EOB'
{"reviews":[{"han":"","appearance":"2010-03-14","post_user":"genkina","kubun_id":1,"source":"日本経済新聞","choyukan":"","source_id":23,"reviewer":"","link":""},{"han":"","appearance":"2010-03-21","post_user":"genkina","kubun_id":1,"source":"読売新聞","choyukan":"","source_id":20,"reviewer":"","link":""}],"datecreated":"2015-08-20 03:22:14","dateshuppan":"2010-02","datemodified":"2015-08-20 03:22:14"}
    EOB
  end

  let(:hanmoto_item) do
    json = JSON.parse(sample_hanmoto_data)
    OpenBD::Resources::Hanmoto.new(json)
  end

  let(:hanmoto_item2) do
    json = JSON.parse(sample_hanmoto_data2)
    OpenBD::Resources::Hanmoto.new(json)
  end

  let(:hanmoto_item3) do
    json = JSON.parse(sample_hanmoto_data3)
    OpenBD::Resources::Hanmoto.new(json)
  end

  it "has a dateshuppan" do
    expect(hanmoto_item.dateshuppan).to be == "2016-06"
  end

  it "has a ruishokyougousho" do
    expect(hanmoto_item.ruishokyougousho).to be == "広井良典『人口減少社会という希望』朝日選書，加藤久和『世代間格差：人口減少社会を問いなおす 』ちくま新書など，人口問題に関する書籍。心理学的な観点に立った書籍は本邦初。"
  end

  it "has jyuhan" do
    expect(hanmoto_item2.jyuhan[0].class).to be == OpenBD::Resources::Hanmoto::Jyuhan
    expect(hanmoto_item2.jyuhan[0].date).to be == "2016-06-23"
    expect(hanmoto_item2.jyuhan[0].comment).to be == "とくに石垣が美しいことで有名な熊本城。本書はその姿をあえてモノクロームで表現しました。2016年4月の熊本地震で大きな被害をうけましたが、当時のうつくしく力強い姿をこれからに残すため、今回緊急増刷することにしました。"
    expect(hanmoto_item2.jyuhan[0].ctime).to be == "2016-06-09 13:43:09"
    expect(hanmoto_item2.jyuhan[0].suri).to be == 3
  end

  it "has an obinaiyou" do
    expect(hanmoto_item.obinaiyou).to be == "人口が減り始めた日本。\n私たちは命にどう関わるべきか？\n命についての問題―生殖補助医療，育児不安，母性，親子，介護，人生の終末―に直面し苦悩し，格闘する心を扱う「人口の心理学」の提案！\n心理学のみならず，人口学，社会学，生命倫理，日本近代史の第一線の論客が結集し，少子化，高齢化，人口減少に直面する日本社会のあり方を問う。"
  end

  it "has a bikoutrc" do
    expect(hanmoto_item.bikoutrc).to be == "トランスビュー取り扱いです"
  end

  it "doesnt have a zasshicode" do
    expect(hanmoto_item.zasshicode).to be_nil
  end

  it "doesnt have a genrecodetrcjidou" do
    expect(hanmoto_item.genrecodetrcjidou).to be_nil
  end

  it "has a bessoushiryou" do
    expect(hanmoto_item.bessoushiryou).to be == "序章　人口の心理学の視点―命と死と生涯発達　●柏木惠子\n第Ⅰ部　誕生―「授かる命」から「つくる命」へ\n第1章　生殖補助医療・不妊治療のいま―心とテクノロジー　●小泉智恵・平山史朗\n第2章　産む選択、産まない選択―出生前診断　●玉井真理子\n第3章　近代日本社会と子どもの命―子返しの習俗と規範の形成　●太田素子\n第4章　血がつながらない子どもの親になる―特別養子縁組による親子の形　●富田庸子\n第Ⅱ部　親子関係―「少子の子ども」と「長命の親」\n第5章　子どもの価値―なぜ、女性は子どもを産むのか　●永久ひさ子\n第6章　育児不安を考える―ライフコースの激変とアイデンティティの揺らぎ　●柏木惠子・加藤邦子\n第7章　もたれ合う家族―日本の家族文化の問題　●舩橋惠子\n第8章　家族が変わる、老親介護も変わる―二一世紀の高齢者の介護と暮らし　●染谷俶子\n第Ⅲ部　命の終わり方―「長命」は「長寿」か\n第9章　人間の尊厳と死―「死の尊厳」の語られ方を読み解く　●大谷いづみ\n第10章　変わるお葬式、消えるお墓―その実態と現代人の意識　●小谷みどり\n第11章　長生きすること―長命の価値と課題　●森岡清美\n終章　少子高齢社会の命と心―現在とこれから　●高橋惠子\n\nコラム \n1　子どもの誕生と死の意味―先人の日記や手紙からの示唆　●柏木惠子\n2　将来の日本がもつ人口問題とは？　●別府志海\n3　日本の貧困　●阿部彩\n4　性・生殖と政治　●高橋惠子\n5　誕生のインファンティア　●西平直\n6　生殖補助医療の死角―当事者の視点から　●加藤英明\n7　「マタニティ・ハラスメント」は女性の身体性への差別　●杉浦浩美\n8　結婚、出産の価値の変化　●本田由紀\n9　なぜ少子に虐待か―家族臨床から見えること　●平木典子\n10　嬰児殺に見る命の重み　●川﨑二三彦\n11　「親孝行の終焉」の示唆するもの　●深谷昌志\n12　平均寿命と健康寿命　●菅原育子\n13　介護保険制度　●神前裕子\n14　江戸時代の高齢化と看取りのシステム　●柳谷慶子\n15　老人ホームに住むという選択　●神前裕子\n16　親孝行は美徳か？―親子間の資源の流れ再考　●柏木惠子\n17　長命化で厳しさを増す親と子のライフプラン　●畠中雅子"
  end

  it "has a ndccode" do
    expect(hanmoto_item.ndccode).to be == "140"
  end

  it "has a kaisetsu105w" do
    expect(hanmoto_item.kaisetsu105w).to be == "命についての問題―生殖補助医療，育児不安，母性，親子，介護，人生の終末―に直面し苦悩し，格闘する心を扱う人口の心理学の提案！今後の日本社会のあり方，そして自分たちの生き方を考える，刺激に満ちた1冊。"
  end

  it "has a datemodified" do
    expect(hanmoto_item.datemodified).to be == "2016-07-05 08:55:26"
  end

  it "has a zaiko" do
    expect(hanmoto_item.zaiko).to be == 11
  end

  it "has a hanmotokarahitokoto" do
    expect(hanmoto_item.hanmotokarahitokoto).to be == "発達心理学を長年にわたりリードしてきたお二人がタッグを組み，現代の日本が直面する人口に関する問題―少子，高齢，人口減少―が私たちの命や死，そして心の発達に何をもたらすのかを読み解いていきます。今後の日本社会のあり方，そして自分たちの生き方を考える，刺激に満ちた1冊です。"
  end

  it "has a author" do
    expect(hanmoto_item.author).to be == [{"listseq"=>1,"dokujikubun"=>"編"},{"listseq"=>2,"dokujikubun"=>"編"}]
  end

  it "has a datecreated" do
    expect(hanmoto_item.datecreated).to be == "2016-05-30 08:23:25"
  end

  it "has reviews" do
    expect(hanmoto_item3.reviews.size).to be == 2
    expect(hanmoto_item3.reviews[0].class).to be == OpenBD::Resources::Hanmoto::Review
  end

  it "has a appearance date" do
    expect(hanmoto_item3.reviews[0].appearance).to be == "2010-03-14"
  end

  it "has a genrecodetrc" do
    expect(hanmoto_item.genrecodetrc).to be == 4
  end

  it "has a toji" do
    expect(hanmoto_item.toji).to be == "並製"
  end

  it "has a kankoukeitai" do
    expect(hanmoto_item.kankoukeitai).to be == "BCD"
  end

  it "has a maegakinado" do
    expect(hanmoto_item.maegakinado).to be == "日本の人口現象―少子化，高齢化，人口減少―つまり，人間の生と死の問題が，私たちの命についての心とその表現としての行動とに深く関わっていることを明らかにしたいと，本書を企画しました。\n人口現象では人間の数（量）の変化に注目が集まりがちです。しかし，この量の変化に潜んでいる，あるいは，量の変化をもたらしている私たちの「命についての考え方」，つまり，質の変化こそが検討されるべきでしょう。人間がどのようにして生まれ，生まれた命をどのように扱い，どのように命を終えるかについての考え方に，革命的ともいえる重大な変化が起こっていることに注目するべきです。本書は，この変化の事実とそこに起こっている問題を明らかにし，さらに，新しい方向を見出すことを企図しています。"
  end
end
