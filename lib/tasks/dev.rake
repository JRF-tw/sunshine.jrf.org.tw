namespace :dev do

  desc "Rebuild from schema.rb"
  task :build => ["tmp:clear", "log:clear", "db:drop", "db:create", "db:schema:load", "dev:fake"]

  desc "Rebuild from migrations"
  task :rebuild => ["tmp:clear", "log:clear", "db:drop", "db:create", "db:migrate", "dev:fake"]

  desc "Generate fake data for development"
  task :fake => [
    "dev:fake_users",
    "dev:fake_courts",
    "dev:fake_profiles",
    "dev:fake_suits",
    "dev:fake_punishments"
  ]

  task :fake_users => :environment do
    User.destroy_all
    email = "admin@5fpro.com"
    user = User.find_by(email: email) || FactoryGirl.create(:user, email: email, password: "12341234", admin: true)
  end

  task :fake_courts => :environment do
    Court.destroy_all
    court_type = Admin::Court::COURT_TYPES.sample
    judge_name_hash = { "臺灣基隆地方法院": "基隆地院", "臺灣臺北地方法院": "臺北地院", "臺灣士林地方法院": "士林地院", "臺灣新北地方法院": "新北地院", "臺灣宜蘭地方法院": "宜蘭地院" }
    prosecutor_name_hash = { "臺灣臺北地方法院檢察署": "臺北地檢署", "臺灣彰化地方法院檢察署": "彰化地檢署", "臺灣臺南地方法院檢察署": "臺南地檢署", "臺灣臺中地方法院檢察署": "臺中地檢署" }
    judge_name_hash.each do |k, v|
      Admin::Court.create!(full_name: k, name: v, court_type: "法院", weight: (1..20).to_a.sample)
    end
    prosecutor_name_hash.each do |k, v|
      Admin::Court.create!(full_name: k, name: v, court_type: "檢察署", weight: (1..20).to_a.sample)
    end
  end

  task :fake_profiles => :environment do
    Profile.destroy_all
    judge_name = ["連添泰", "蕭健銘", "謝孟蓮", "陳信宏", "趙定輝", "賴雅婷", "梁貴鑫", "林旭弘", "陳宛臻", "陳幸愛"]
    prosecutor_name = ["郭耿妹", "蔡宜玉", "賴枝仰", "李孟霞", "洪偉裕", "張育如", "黃秀琴", "吳秀芬", "周哲銘", "施依婷"]
    judge_name.each do |n|
      Admin::Profile.create!(name: n, current: "法官", gender: Admin::Profile::GENDER_TYPES.sample, birth_year: (50..70).to_a.sample)
    end
    prosecutor_name.each do |n|
      Admin::Profile.create!(name: n, current: "檢察官", gender: Admin::Profile::GENDER_TYPES.sample, birth_year: (50..70).to_a.sample)
    end
  end

  task :fake_suits => :environment do
    Suit.destroy_all
    titles = ["我的願構調王出", "那作之所好能一地", "新布類系眼美成的子", "晚適事制質一銷可麗民", "色手黃備型食勢我成原動", "春資一臺無反的共的家示例", "林全無間一新進遊然統國德足", "機來了各正又解手孩目這走運醫", "多制負能狀隨方計算自化的中已廣"]
    text = ["的世業銷一食今方無想產做前，養他熱：氣總男極！利見體？道不自原結位手。備叫然目功物的展這得界遊我世專關情長道快眼不到首麼員候風：酒作速等，人清今重離燈氣黃運少主馬多風構沒原在性麼注不愛自下以少講劇了的兩，後頭說怎處作女間了花天！", "局有歌升個國民起本己想作成下為在…… 度模復場對接西明家風你。道我功部語育，學不他車義活環教手國開…… 了人又回不己念時來的港不包感的結事率成現？來集落，禮的愛結許能朋海中都個時，員足萬亮同進的居質動，著不的；感沒於大廣天；看時交放種活原素設後而活我財臺不邊類港以子果？", "力年華。力步說建產阿；此清一是了現學報同放所書旅怕聽代…… 石麼高經應邊的校自位專，電行氣！因上信你！境產幾樣讓友二打子認平心投，方不要易呢中影多開生到生型自準示車男公臺小不。"]
    titles.each do |t|
      judge_ids = Profile.judges.shuffle.last(3).map(&:id)
      prosecutor_ids = Profile.prosecutors.shuffle.last(3).map(&:id)
      summary = text.sample
      content = text.sample
      suit_no = (1000..1200).to_a.sample
      state = Admin::Suit::STATE.sample
      suit = Admin::Suit.create!(title: t, state: state, suit_no: suit_no, summary: summary, content: content)
      judge_ids.each do |j|
        suit.suit_judges.create!(profile_id: j)
      end
      prosecutor_ids.each do |p|
        suit.suit_judges.create!(profile_id: p)
      end
    end
  end

  task :fake_punishments => :environment do
    Punishment.destroy_all
    decision_units = ["公懲會", "檢評會", "監察院(新)", "監察院(舊)", "職務法庭", "法評會", "司法院"]
    Admin::Profile.all.each do |p|
      p.punishments.create!(decision_unit: decision_units.sample)
    end
  end
end