namespace :dev do

  desc 'Rebuild from schema.rb'
  task build: ['tmp:clear', 'log:clear', 'db:drop', 'db:create', 'db:schema:load', 'dev:fake']

  desc 'Rebuild from migrations'
  task rebuild: ['tmp:clear', 'log:clear', 'db:drop', 'db:create', 'db:migrate', 'dev:fake']

  desc 'Generate fake data for development'
  task fake: [
    'dev:fake_users',
    'dev:fake_courts_and_prosecutors_offices',
    'dev:fake_profiles',
    'dev:fake_judges',
    'dev:fake_prosecutors',
    'dev:fake_educations',
    'dev:fake_careers',
    'dev:fake_licenses',
    'dev:fake_awards',
    'dev:fake_reviews',
    'dev:fake_articles',
    'dev:fake_punishments',
    'dev:fake_banners',
    'dev:fake_bulletins',
    'dev:fake_stories',
    'dev:fake_schedules',
    'dev:fake_lawyers',
    'dev:fake_verdicts',
    'dev:fake_rules'
  ]

  task fake_users: :environment do
    User.destroy_all
    email = 'admin@jrf.org.tw'
    User.find_by(email: email) || FactoryGirl.create(:user, email: email, password: 'P@ssw0rd', admin: true)
  end

  task fake_courts_and_prosecutors_offices: :environment do
    Court.destroy_all
    ProsecutorsOffice.destroy_all
    judge_name_hash = { '臺灣基隆地方法院': '基隆地院', '臺灣臺北地方法院': '臺北地院', '臺灣士林地方法院': '士林地院', '臺灣新北地方法院': '新北地院', '臺灣宜蘭地方法院': '宜蘭地院' }
    judge_name_hash.each do |k, v|
      court = Admin::Court.create!(full_name: k, name: v, weight: (1..20).to_a.sample)
      Admin::ProsecutorsOffice.create!(full_name: k.to_s + '檢察署', name: v.gsub('院', '檢署'), court: court)
    end
  end

  task fake_profiles: :environment do
    Profile.destroy_all
    judge_name = Array.new(150) { |i| "測試法官 - #{i + 1}" }
    judge_name.each do |n|
      file = File.open "#{Rails.root}/spec/fixtures/person_avatar/people-#{rand(1..12)}.jpg"
      Admin::Profile.create!(name: n, current: '法官', gender: User::GENDER_TYPES.sample, birth_year: rand(50..70), avatar: file, is_active: true, is_hidden: false, current_court: '臺灣臺北地方法院')
    end
  end

  task fake_judges: :environment do
    Judge.destroy_all
    judge_name = Array.new(30) { |i| "測試法官-#{i + 1}" }
    gender = ['男', '女', '其他']
    judge_name.each_with_index do |n, _i|
      file = File.open "#{Rails.root}/spec/fixtures/person_avatar/people-23.jpg"
      Court.all.sample.judges.create!(name: n, gender: gender.sample, birth_year: (50..70).to_a.sample, avatar: file, is_active: true, is_hidden: false)
    end
  end

  task fake_prosecutors: :environment do
    Prosecutor.destroy_all
    prosecutor_name = Array.new(30) { |i| "測試檢察官 - #{i + 1}" }
    gender = ['男', '女', '其他']
    prosecutor_name.each_with_index do |n, _i|
      file = File.open "#{Rails.root}/spec/fixtures/person_avatar/people-23.jpg"
      ProsecutorsOffice.all.sample.prosecutors.create!(name: n, gender: gender.sample, birth_year: (50..70).to_a.sample, avatar: file, is_active: true, is_hidden: false)
    end
  end

  task fake_lawyers: :environment do
    Lawyer.destroy_all
    lawyer_name = ['謝祖武', '陳金城', '王定輝', '張耀仁', '蔡有訓', '游志嘉', '陳昊', '林哲毓', '方勇正', '王雪徵', '卓俊瑋']
    current = ['土城事務所', '三重事務所', '金山事務所', '萬里事務所', '板橋事務所', '新莊事務所', '士林事務所']
    gender = ['男', '女', '其他']
    file = File.open "#{Rails.root}/spec/fixtures/person_avatar/people-#{rand(1..10)}.jpg"
    lawyer_name.each do |n|
      Lawyer.create!(email: "lawyer-#{lawyer_name.index(n)}@example.com", password: '11111111', name: n, current: current.sample, gender: gender.sample, birth_year: rand(50..70), avatar: file)
    end
  end

  task fake_educations: :environment do
    Education.destroy_all
    titles = ['政治大學法律系', '台灣大學法律系', '中正大學法律系', '清華大學法律系', '交通大學法律系', '為理法律事務所律師', '聯大法律事務所律師', '永然聯合法律事務所律師', '人生法律事務所律師', '鄉民法律事務所律師', '聯合法律事務所律師', '不知道法律事務所律師', '華南永昌證券法務主管', '第一名法律事務所律師']
    Admin::Profile.all.each do |p|
      (3..5).to_a.sample.times do
        p.educations.create!(title: titles.sample, is_hidden: false)
      end
    end
  end

  task fake_careers: :environment do
    Career.destroy_all
    career_types = ['任命', '調派', '再次調任', '首次調任', '提前回任', '調任', '歸建', '請辭', '再任', '留任', '調升', '調任歷練', '歷練遷調']
    titles = ['檢察官', '副司長', '檢察長', '法官', '主任檢察官']
    Admin::Profile.last(10).each do |p|
      (3..5).to_a.sample.times do
        p.careers.create!(career_type: career_types.sample, new_unit: Admin::Court.all.sample.full_name, new_title: titles.sample, publish_at: rand(20).years.ago, is_hidden: false)
      end
    end
  end

  task fake_licenses: :environment do
    License.destroy_all
    license_types = ['家事類型專業法官證明書', '刑事醫療類型專業法官證明書', '勞工類型專業法官證明書', '行政訴訟類型專業法官證明書', '少年類型專業法官證明書', '民事智慧財產類型專業法官證明書', '民事營造工程類型專業法官證明書']
    titles = ['檢察官', '副司長', '檢察長', '法官', '主任檢察官']
    Admin::Profile.all.each do |p|
      (3..5).to_a.sample.times do
        p.licenses.create!(license_type: license_types.sample, unit: Admin::Court.all.sample.full_name, title: titles.sample, publish_at: rand(20).years.ago, is_hidden: false)
      end
    end
  end

  task fake_awards: :environment do
    Award.destroy_all
    award_types = ['嘉獎一次', '小功一次', '大功一次', '一等司法獎章', '法眼明察獎']
    unit = ['司法院', '法務部']
    text = ['的世業銷一食今方無想產做前，養他熱：氣總男極！利見體？道不自原結位手。備叫然目功物的展這得界遊我世專關情長道快眼不到首麼員候風：酒作速等，人清今重離燈氣黃運少主馬多風構沒原在性麼注不愛自下以少講劇了的兩，後頭說怎處作女間了花天！', '局有歌升個國民起本己想作成下為在…… 度模復場對接西明家風你。道我功部語育，學不他車義活環教手國開…… 了人又回不己念時來的港不包感的結事率成現？來集落，禮的愛結許能朋海中都個時，員足萬亮同進的居質動，著不的；感沒於大廣天；看時交放種活原素設後而活我財臺不邊類港以子果？', '力年華。力步說建產阿；此清一是了現學報同放所書旅怕聽代…… 石麼高經應邊的校自位專，電行氣！因上信你！境產幾樣讓友二打子認平心投，方不要易呢中影多開生到生型自準示車男公臺小不。']
    Admin::Profile.all.each do |p|
      (1..3).to_a.sample.times do
        p.awards.create!(award_type: award_types.sample, content: text.sample, unit: unit.sample, publish_at: rand(20).years.ago, is_hidden: false)
      end
    end
  end

  task fake_reviews: :environment do
    Review.destroy_all
    names = ['蘋果日報', '法務部新聞稿', '聯合報', 'PChome Online 新聞', '自由時報', '中國時報', '民報']
    titles = ['我的願構調王出', '那作之所好能一地', '新布類系眼美成的子', '晚適事制質一銷可麗民', '色手黃備型食勢我成原動', '春資一臺無反的共的家示例', '林全無間一新進遊然統國德足', '機來了各正又解手孩目這走運醫', '多制負能狀隨方計算自化的中已廣']
    Admin::Profile.all.each do |p|
      (5..15).to_a.sample.times do
        p.reviews.create!(name: names.sample, title: titles.sample, source: 'https://www.google.com.tw', publish_at: rand(20).years.ago, is_hidden: false)
      end
    end
  end

  task fake_articles: :environment do
    Article.destroy_all
    article_types = ['編輯專書', '期刊文章', '會議論文', '報紙投書', '專書', '碩博士論文']
    titles = ['我的願構調王出', '那作之所好能一地', '新布類系眼美成的子', '晚適事制質一銷可麗民', '色手黃備型食勢我成原動', '春資一臺無反的共的家示例', '林全無間一新進遊然統國德足', '機來了各正又解手孩目這走運醫', '多制負能狀隨方計算自化的中已廣']
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

  task fake_punishments: :environment do
    Punishment.destroy_all
    decision_units = ['公懲會', '檢評會', '監察院(新)', '監察院(舊)', '職務法庭', '法評會', '司法院']
    reasons = ['請求個案評鑑', '受評鑑人有懲戒之必要，報由法務部移送監察院審查，建議休職二年。', '休職，期間壹年陸月。', '受評鑑法官詹駿鴻報由司法院交付司法院人事審議委員會審議，建議處分記過貳次。', '警告處分', '本件請求不成立，並移請職務監督權人為適當之處分']
    Admin::Profile.all.each do |p|
      p.punishments.create!(decision_unit: decision_units.sample, reason: reasons.sample, is_hidden: false)
    end
  end

  task fake_banners: :environment do
    Banner.destroy_all
    2.times do |i|
      Admin::Banner.create!(
        title: "我是標題-#{i}",
        desc: "我是描述-#{i}",
        link: 'http://example.com',
        btn_wording: "我是按鈕文字-#{i}",
        pic: File.open("#{Rails.root}/spec/fixtures/banner/M_banner_#{i + 1}.jpg"),
        weight: i + 1
      )
    end
  end

  task fake_bulletins: :environment do
    Bulletin.destroy_all
    content = ["\r\n\r\n<h1>我今天想吃薯條</h1>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><em><strong><span style=\"color:#ff8c00\"><span style=\"font-size:16px\">不想吃漢堡</span></span></strong></em></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><em><strong><span style=\"color:#ff8c00\"><span style=\"font-size:16px\">真假啦</span></span></strong></em></p>\r\n",
               "<ol>\r\n\t<li><s>我要當老師</s></li>\r\n\t<li><u>我要當老闆</u></li>\r\n\t<li>\r\n\t<h3>我要當老婆</h3>\r\n\t</li>\r\n\t<li><em>我要當老狗一條</em></li>\r\n</ol>\r\n\r\n<p><span style=\"font-size:16px\"><strong>今天天氣不錯</strong></span></p>\r\n"]
    12.times do |i|
      Admin::Bulletin.create!(
        title: "重要公告-#{i}",
        content: content.sample,
        pic: File.open("#{Rails.root}/spec/fixtures/banner/L_banner_#{[1, 2].sample}.jpg")
      )
    end
  end

  task fake_stories: :environment do
    Story.destroy_all
    10.times do |_i|
      Court.all.sample.stories.create!(
        story_type: ['民事', '邢事'].sample,
        year: rand(70..105),
        word_type: ['生', '老', '病', '死'].sample,
        number: rand(100..999),
        adjudged_on: rand(5).years.ago
      )
    end
  end

  task fake_verdicts: :environment do
    Verdict.destroy_all
    5.times do |_i|
      Verdict.create(story: Story.all.sample, adjudged_on: rand(5).years.ago, published_on: rand(5).years.ago)
    end
  end

  task fake_rules: :environment do
    Rule.destroy_all
    5.times do |_i|
      Story.all.sample.rules.create!(published_on: rand(5).years.ago)
    end
  end

  task fake_schedules: :environment do
    Schedule.destroy_all
    Story.all.each do |story|
      story.court.schedules.create!(
        branch_name: ['信', '愛', '美', '德'].sample,
        start_on: rand(5).years.ago,
        story: story
      )
    end
  end

  task fake_schedule: :environment do
    court = FactoryGirl.create(:court, full_name: "測試法院-#{Time.now}")
    judge = FactoryGirl.create(:judge, court: court, name: "測試法官-#{Time.now}")
    story = FactoryGirl.create(:story, court: court)
    schedule = FactoryGirl.create(:schedule, court: court, story: story, branch_judge: judge)

    puts "該庭期案件類別 = #{schedule.story.story_type}"
    puts "該庭期案件年份 = #{schedule.story.year}"
    puts "該庭期案件字號 = #{schedule.story.word_type}"
    puts "該庭期案件案號 = #{schedule.story.number}"
    puts "該庭期隸屬法院 = #{schedule.court.full_name}"
    puts "該庭期開庭日期 = #{schedule.start_on}"
    puts "該庭期隸屬股別法官名稱 = #{schedule.branch_judge.name}"
  end

  task fake_verdict: :environment do
    court = FactoryGirl.create(:court, full_name: "測試法院-#{Time.now}")
    story = FactoryGirl.create(:story, court: court, is_adjudged: true, adjudged_on: Time.now)
    verdict = FactoryGirl.create(:verdict, story: story, adjudged_on: Time.now)

    puts "該判決書案件類別 = #{verdict.story.story_type}"
    puts "該判決書案件年份 = #{verdict.story.year}"
    puts "該判決書案件字號 = #{verdict.story.word_type}"
    puts "該判決書案件案號 = #{verdict.story.number}"
    puts "該判決書隸屬法院 = #{verdict.story.court.full_name}"
    puts "該判決書宣判日期 = #{verdict.adjudged_on}"
  end

end
