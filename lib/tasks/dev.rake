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
    "dev:fake_judges",
    "dev:fake_educations",
    "dev:fake_careers",
    "dev:fake_licenses",
    "dev:fake_awards",
    "dev:fake_reviews",
    "dev:fake_articles",
    "dev:fake_judgments",
    "dev:fake_suits",
    "dev:fake_procedures",
    "dev:fake_punishments",
    "dev:fake_banners",
    "dev:fake_suit_banners",
    "dev:fake_stories",
    "dev:fake_schedules",
    "dev::fake_lawyer"
  ]

  task :fake_users => :environment do
    User.destroy_all
    email = "admin@jrf.org.tw"
    user = User.find_by(email: email) || FactoryGirl.create(:user, email: email, password: "P@ssw0rd", admin: true)
  end

  task :fake_courts => :environment do
    Court.destroy_all
    court_type = ["法院", "檢察署"].sample
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
    judge_name = ["連添泰", "蕭健銘", "謝孟蓮", "陳信宏", "趙定輝", "賴雅婷", "梁貴鑫", "林旭弘", "陳宛臻", "陳幸愛", "李欣宸", "阮宜臻"]
    prosecutor_name = ["郭耿妹", "蔡宜玉", "賴枝仰", "李孟霞", "洪偉裕", "張育如", "黃秀琴", "吳秀芬", "周哲銘", "施依婷", "賴元士", "王珮瑜"]
    judge_name.each_with_index do |n, i|
      file = File.open "#{Rails.root}/spec/fixtures/person_avatar/people-#{i+1}.jpg"
      Admin::Profile.create!(name: n, current: "法官", gender: Admin::Profile::GENDER_TYPES.sample, birth_year: (50..70).to_a.sample, avatar: file, is_active:true, is_hidden: false)
    end
    prosecutor_name.each_with_index do |n, i|
      file = File.open "#{Rails.root}/spec/fixtures/person_avatar/people-#{i+13}.jpg"
      Admin::Profile.create!(name: n, current: "檢察官", gender: Admin::Profile::GENDER_TYPES.sample, birth_year: (50..70).to_a.sample, avatar: file, is_active:true, is_hidden: false)
    end
  end

  task :fake_judges => :environment do
    Judge.destroy_all
    judge_name = ["連添泰", "蕭健銘", "謝孟蓮", "陳信宏", "趙定輝", "賴雅婷", "梁貴鑫", "林旭弘", "陳宛臻", "陳幸愛", "李欣宸", "阮宜臻"]
    gender = ["男", "女", "其他"]
    judge_name.each_with_index do |n, i|
      file = File.open "#{Rails.root}/spec/fixtures/person_avatar/people-23.jpg"
      Court.get_courts.sample.judges.create!(name: n, gender: gender.sample, birth_year: (50..70).to_a.sample, avatar: file, is_active:true, is_hidden: false)
    end
  end  

  task :fake_lawyer => :environment do
    Lawyer.destroy_all
    lawyer_name = ["謝祖武" , "陳金城", "王定輝", "張耀仁", "蔡有訓", "游志嘉", "陳昊", "林哲毓", "方勇正", "王雪徵", "卓俊瑋"]
    current = ["見習律師", "律師", "大律師"]
    gender = ["男", "女", "其他"]
    file = File.open "#{Rails.root}/spec/fixtures/person_avatar/people-10.jpg"
    lawyer_name.each do |n|
      Lawyer.create!(name: n, current: current.sample, gender: gender.sample, birth_year: (50..70).to_a.sample, avatar: file)
    end
  end       

  task :fake_educations => :environment do
    Education.destroy_all
    titles = ["政治大學法律系", "台灣大學法律系", "中正大學法律系", "清華大學法律系", "交通大學法律系", "為理法律事務所律師", "聯大法律事務所律師", "永然聯合法律事務所律師", "人生法律事務所律師", "鄉民法律事務所律師", "聯合法律事務所律師", "不知道法律事務所律師", "華南永昌證券法務主管", "第一名法律事務所律師"]
    Admin::Profile.all.each do |p|
      (3..5).to_a.sample.times do
        p.educations.create!(title: titles.sample, is_hidden: false)
      end
    end
  end

  task :fake_careers => :environment do
    Career.destroy_all
    career_types = ["任命", "調派", "再次調任" ,"首次調任", "提前回任", "調任", "歸建", "請辭", "再任", "留任", "調升", "調任歷練", "歷練遷調"]
    titles = ["檢察官", "副司長", "檢察長", "法官", "主任檢察官"]
    Admin::Profile.all.each do |p|
      (3..5).to_a.sample.times do
        p.careers.create!(career_type: career_types.sample, new_unit: Admin::Court.all.sample.full_name, new_title: titles.sample, publish_at: rand(20).years.ago, is_hidden: false)
      end
    end
  end

  task :fake_licenses => :environment do
    License.destroy_all
    license_types = ["家事類型專業法官證明書", "刑事醫療類型專業法官證明書", "勞工類型專業法官證明書", "行政訴訟類型專業法官證明書", "少年類型專業法官證明書", "民事智慧財產類型專業法官證明書", "民事營造工程類型專業法官證明書"]
    titles = ["檢察官", "副司長", "檢察長", "法官", "主任檢察官"]
    Admin::Profile.all.each do |p|
      (3..5).to_a.sample.times do
        p.licenses.create!(license_type: license_types.sample, unit: Admin::Court.all.sample.full_name, title: titles.sample, publish_at: rand(20).years.ago, is_hidden: false)
      end
    end
  end

  task :fake_awards => :environment do
    Award.destroy_all
    award_types = ["嘉獎一次", "小功一次", "大功一次", "一等司法獎章", "法眼明察獎"]
    unit = ["司法院", "法務部"]
    text = ["的世業銷一食今方無想產做前，養他熱：氣總男極！利見體？道不自原結位手。備叫然目功物的展這得界遊我世專關情長道快眼不到首麼員候風：酒作速等，人清今重離燈氣黃運少主馬多風構沒原在性麼注不愛自下以少講劇了的兩，後頭說怎處作女間了花天！", "局有歌升個國民起本己想作成下為在…… 度模復場對接西明家風你。道我功部語育，學不他車義活環教手國開…… 了人又回不己念時來的港不包感的結事率成現？來集落，禮的愛結許能朋海中都個時，員足萬亮同進的居質動，著不的；感沒於大廣天；看時交放種活原素設後而活我財臺不邊類港以子果？", "力年華。力步說建產阿；此清一是了現學報同放所書旅怕聽代…… 石麼高經應邊的校自位專，電行氣！因上信你！境產幾樣讓友二打子認平心投，方不要易呢中影多開生到生型自準示車男公臺小不。"]
    Admin::Profile.all.each do |p|
      (1..3).to_a.sample.times do
        p.awards.create!(award_type: award_types.sample, content: text.sample, unit: unit.sample, publish_at: rand(20).years.ago, is_hidden: false)
      end
    end
  end

  task :fake_reviews => :environment do
    Review.destroy_all
    names = ["蘋果日報", "法務部新聞稿", "聯合報", "PChome Online 新聞", "自由時報", "中國時報", "民報"]
    titles = ["我的願構調王出", "那作之所好能一地", "新布類系眼美成的子", "晚適事制質一銷可麗民", "色手黃備型食勢我成原動", "春資一臺無反的共的家示例", "林全無間一新進遊然統國德足", "機來了各正又解手孩目這走運醫", "多制負能狀隨方計算自化的中已廣"]
    Admin::Profile.all.each do |p|
      (5..15).to_a.sample.times do
        p.reviews.create!(name: names.sample, title: titles.sample, source: "https://www.google.com.tw", publish_at: rand(20).years.ago, is_hidden: false)
      end
    end
  end

  task :fake_articles => :environment do
    Article.destroy_all
    article_types = ["編輯專書", "期刊文章", "會議論文", "報紙投書", "專書", "碩博士論文"]
    titles = ["我的願構調王出", "那作之所好能一地", "新布類系眼美成的子", "晚適事制質一銷可麗民", "色手黃備型食勢我成原動", "春資一臺無反的共的家示例", "林全無間一新進遊然統國德足", "機來了各正又解手孩目這走運醫", "多制負能狀隨方計算自化的中已廣"]
    Admin::Profile.all.each do |p|
      (1..3).to_a.sample.times do
        p.articles.create!(article_type: article_types.sample, book_title: titles.sample, title: titles.sample, publish_year: (70..105).to_a.sample, is_hidden: false)
      end
      (1..3).to_a.sample.times do
        p.articles.create!(article_type: article_types.sample, book_title: titles.sample, title: titles.sample, paper_publish_at: rand(20).years.ago, is_hidden: false)
      end
      (1..3).to_a.sample.times do
        p.articles.create!(article_type: article_types.sample, book_title: titles.sample, title: titles.sample, news_publish_at: rand(20).years.ago, is_hidden: false)
      end
    end
  end

  task :fake_judgments => :environment do
    Judgment.destroy_all
    50.times do |i|
      court = Admin::Court.get_courts.sample
      presiding_judge = Admin::Profile.judges.sample
      main_judge = Admin::Profile.judges.sample
      judge_nos = ["我的願構調王出#{i}", "那作之所好能一地#{i}", "新布類系眼美成的子#{i}", "晚適事制質一銷可麗民#{i}", "色手黃備型食勢我成原動#{i}"]
      court_nos = ["#{i}我的願構調王出", "#{i}那作之所好能一地", "#{i}新布類系眼美成的子", "#{i}晚適事制質一銷可麗民", "#{i}色手黃備型食勢我成原動"]
      judge_type = Admin::Judgment::JUDGMENT_TYPES.sample
      judgment = Admin::Judgment.create!(court: court, presiding_judge: presiding_judge, main_judge: main_judge, judge_no: judge_nos.sample, court_no: court_nos.sample, judge_type: judge_type, judge_date: rand(20).years.ago , is_hidden: false)
      judge_ids = Profile.judges.shuffle.last((1..3).to_a.sample).map(&:id)
      prosecutor_ids = Profile.prosecutors.shuffle.last((1..3).to_a.sample).map(&:id)
      judge_ids.each do |j|
        judgment.judgment_judges.create!(profile_id: j)
      end
      prosecutor_ids.each do |p|
        judgment.judgment_prosecutors.create!(profile_id: p)
      end
    end
  end

  task :fake_suits => :environment do
    Suit.destroy_all
    titles = ["我的願構調王出", "那作之所好能一地", "新布類系眼美成的子", "晚適事制質一銷可麗民", "色手黃備型食勢我成原動", "春資一臺無反的共的家示例", "林全無間一新進遊然統國德足", "機來了各正又解手孩目這走運醫", "多制負能狀隨方計算自化的中已廣"]
    text = ["的世業銷一食今方無想產做前，養他熱：氣總男極！利見體？道不自原結位手。備叫然目功物的展這得界遊我世專關情長道快眼不到首麼員候風：酒作速等，人清今重離燈氣黃運少主馬多風構沒原在性麼注不愛自下以少講劇了的兩，後頭說怎處作女間了花天！", "局有歌升個國民起本己想作成下為在…… 度模復場對接西明家風你。道我功部語育，學不他車義活環教手國開…… 了人又回不己念時來的港不包感的結事率成現？來集落，禮的愛結許能朋海中都個時，員足萬亮同進的居質動，著不的；感沒於大廣天；看時交放種活原素設後而活我財臺不邊類港以子果？", "力年華。力步說建產阿；此清一是了現學報同放所書旅怕聽代…… 石麼高經應邊的校自位專，電行氣！因上信你！境產幾樣讓友二打子認平心投，方不要易呢中影多開生到生型自準示車男公臺小不。"]
    keywords = ["態度不佳", "撤回上訴", "侵越權限","不正訊問", "憤怒鳥檢察官", "測試關鍵字"]
    titles.each_with_index do |t, i|
      judge_ids = Profile.judges.shuffle.last((2..5).to_a.sample).map(&:id)
      prosecutor_ids = Profile.prosecutors.shuffle.last((2..5).to_a.sample).map(&:id)
      summary = text.sample
      content = text.sample
      suit_no = (1000..1200).to_a.sample
      state = Suit::STATE.sample
      keyword = keywords.shuffle.last((1..3).to_a.sample).join(',')
      file = File.open "#{Rails.root}/spec/fixtures/suit_pic/case-#{i+1}.jpg"
      suit = Admin::Suit.create!(title: t, state: state, suit_no: suit_no, summary: summary, content: content, pic: file, keyword: keyword, is_hidden: false)
      judge_ids.each do |j|
        suit.suit_judges.create!(profile_id: j)
      end
      prosecutor_ids.each do |p|
        suit.suit_prosecutors.create!(profile_id: p)
      end
    end
  end

  task :fake_procedures => :environment do
    Procedure.destroy_all
    Admin::Suit.all.each do |suit|
      (2..5).to_a.sample.times do
        profile = (suit.judges + suit.prosecutors).sample
        unit = Admin::Court.all.sample
        titles = ["檢察官", "副司長", "檢察長", "法官", "主任檢察官"]
        procedure_units = ["司改會", "檢評會", "監察院", "法評會", "司法院人審會"]
        procedure_contents = ["結束", "行政處理中"]
        procedure_results = ["請求個案評鑑", "受評鑑人有懲戒之必要，報由法務部移送監察院審查，建議休職二年。", "休職，期間壹年陸月。", "受評鑑法官詹駿鴻報由司法院交付司法院人事審議委員會審議，建議處分記過貳次。", "警告處分", "本件請求不成立，並移請職務監督權人為適當之處分"]
        suit.procedures.create!(profile: profile, unit: unit.name, title: titles.sample, procedure_unit: procedure_units.sample, procedure_content: procedure_contents.sample, procedure_result: procedure_results.sample, procedure_date: rand(20).years.ago, suit_no: suit.suit_no, procedure_no: "#{(90..105).to_a.sample}年檢評字第#{(1..100).to_a.sample}號", is_hidden: false)
      end
    end
    Suit.all.each {|suit| suit.update_attributes(is_hidden: false)}
  end

  task :fake_punishments => :environment do
    Punishment.destroy_all
    decision_units = ["公懲會", "檢評會", "監察院(新)", "監察院(舊)", "職務法庭", "法評會", "司法院"]
    reasons = ["請求個案評鑑", "受評鑑人有懲戒之必要，報由法務部移送監察院審查，建議休職二年。", "休職，期間壹年陸月。", "受評鑑法官詹駿鴻報由司法院交付司法院人事審議委員會審議，建議處分記過貳次。", "警告處分", "本件請求不成立，並移請職務監督權人為適當之處分"]
    Admin::Profile.all.each do |p|
      p.punishments.create!(decision_unit: decision_units.sample, reason: reasons.sample, is_hidden: false)
    end
  end

  task :fake_banners => :environment do
    Banner.destroy_all
    2.times do |i|
      Admin::Banner.create!(
        pic_l: File.open("#{Rails.root}/spec/fixtures/banner/L_banner_#{i+1}.jpg"),
        pic_m: File.open("#{Rails.root}/spec/fixtures/banner/M_banner_#{i+1}.jpg"),
        pic_s: File.open("#{Rails.root}/spec/fixtures/banner/S_banner_#{i+1}.jpg"),
        weight: i+1
      )
    end
  end

  task :fake_suit_banners => :environment do
    SuitBanner.destroy_all
    urls = ["https://www.facebook.com", "https://www.google.com", "https://www.yahoo.com"]
    titles = ["我的願構調王出", "那作之所好能一地", "新布類系眼美成的子", "晚適事制質一銷可麗民", "色手黃備型食勢我成原動", "春資一臺無反的共的家示例", "林全無間一新進遊然統國德足", "機來了各正又解手孩目這走運醫", "多制負能狀隨方計算自化的中已廣"]
    text = ["的世業銷一食今方無想產做前，養他熱：氣總男極！利見體？道不自原結位手。備叫然目功物的展這得界遊我世專關情長道快眼不到首麼員候風：酒作速等，人清今重離燈氣黃運少主馬多風構沒原在性麼注不愛自下以少講劇了的兩，後頭說怎處作女間了花天！", "局有歌升個國民起本己想作成下為在…… 度模復場對接西明家風你。道我功部語育，學不他車義活環教手國開…… 了人又回不己念時來的港不包感的結事率成現？來集落，禮的愛結許能朋海中都個時，員足萬亮同進的居質動，著不的；感沒於大廣天；看時交放種活原素設後而活我財臺不邊類港以子果？", "力年華。力步說建產阿；此清一是了現學報同放所書旅怕聽代…… 石麼高經應邊的校自位專，電行氣！因上信你！境產幾樣讓友二打子認平心投，方不要易呢中影多開生到生型自準示車男公臺小不。"]
    urls.each_with_index do |url, i|
      Admin::SuitBanner.create!(
        pic_l: File.open("#{Rails.root}/spec/fixtures/suit_banner/case_#{i+1}.jpg"),
        pic_m: File.open("#{Rails.root}/spec/fixtures/suit_banner/case_#{i+1}.jpg"),
        pic_s: File.open("#{Rails.root}/spec/fixtures/suit_banner/case_#{i+1}.jpg"),
        url: url, title: titles.sample, content: text.sample, weight: i+1
      )
    end
  end

  task :fake_stories => :environment do
    Story.destroy_all
    10.times do |i|
      Court.all.sample.stories.create!(
        story_type: ["民事", "邢事"].sample,
        year: rand(70..105),
        word_type: ["生", "老", "病", "死"].sample,
        number: rand(100..999)
      )
    end
  end

  task :fake_schedules => :environment do
    Schedule.destroy_all
    Story.all.each do |story|
      story.court.schedules.create!(
        branch_name: ["信", "愛" , "美", "德"].sample,
        date: rand(5).years.ago,
        story: story
      )
    end  
  end    
 
end
