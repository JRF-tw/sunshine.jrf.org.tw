# encoding: UTF-8
module ZhLoremHelper
  # Returns a random Chinese name.
  def zh_lorem_name(replacement = nil)
    if replacement
      replacement
    else
      zh_lorem_last_name + zh_lorem_first_name
    end
  end

  # Returns a random Chinese name in pinyin form
  def zh_lorem_name_pinyin(replacement = nil)
    if replacement
      return replacement
    end

    zh_lorem_first_name_pinyin + ' ' + zh_lorem_last_name_pinyin
  end

  # Returns a random Chinese firstname
  def zh_lorem_first_name(replacement = nil)
    if replacement
      return replacement
    end

    x = %w(世 中 仁 伶 佩 佳 俊 信 倫 偉 傑 儀 元 冠 凱 君 哲 嘉 國 士 如 娟 婷 子 孟 宇 安 宏 宗 宜 家 建 弘 強 彥 彬 德 心 志 忠 怡 惠 慧 慶 憲 成 政 敏 文 昌 明 智 曉 柏 榮 欣 正 民 永 淑 玉 玲 珊 珍 珮 琪 瑋 瑜 瑞 瑩 盈 真 祥 秀 秋 穎 立 維 美 翔 翰 聖 育 良 芬 芳 英 菁 華 萍 蓉 裕 豪 貞 賢 郁 鈴 銘 雅 雯 霖 青 靜 韻 鴻 麗 龍)
    x[rand(x.size)] + (rand(2) == 0 ? '' : x[rand(x.size)])
  end

  # Returns a random Chinese firstname in pinyin form
  def zh_lorem_first_name_pinyin(replacement = nil)
    if replacement
      return replacement
    end
    x = %w(Lee Wang Chang Liu Cheng Yang Huang Zhao Zho Wu Schee Sun Zhu Ma Hu Guo Lin Ho Kao Liang Zheng Luo Sung Hsieh Tang Han Cao Xu Deng Xiao Feng Tseng Tsai Peng Pan Yuan Yu Tong Su Ye Lu Wei Jiang Tian Tu Ting Shen Jiang Fan Fu Zhong Lu Wang Dai Cui Ren Liao Yiao Fang Jin Qiu Xia Jia Chu Shi Xiong Meng Qin Yan Xue Ho Lei Bai Long Duan Hao Kong Shao Shi Mao Wan Gu Lai Kang He Yi Qian Niu Hung Gung)

    x[rand(x.size)] + (rand(2) == 0 ? '' : x[rand(x.size)].downcase)
  end

  # Returns a random Chinese lastname.
  def zh_lorem_last_name(replacement = nil)
    if replacement
      return replacement
    end

    x = %w(李 王 張 劉 陳 楊 黃 趙 周 吳 徐 孫 朱 馬 胡 郭 林 何 高 梁 鄭 羅 宋 謝 唐 韓 曹 許 鄧 蕭 馮 曾 程 蔡 彭 潘 袁 於 董 餘 蘇 葉 呂 魏 蔣 田 杜 丁 沈 姜 範 江 傅 鐘 盧 汪 戴 崔 任 陸 廖 姚 方 金 邱 夏 譚 韋 賈 鄒 石 熊 孟 秦 閻 薛 侯 雷 白 龍 段 郝 孔 邵 史 毛 常 萬 顧 賴 武 康 賀 嚴 尹 錢 施 牛 洪 龔)
    x[rand(x.size)]
  end

  # Returns a ranodm Chinese lastname in pinyin form
  def zh_lorem_last_name_pinyin(replacement = nil)
    if replacement
      return replacement
    end

    x = %w(Li Wang Zhang Liu Chen Yang Huang Zhao Zhou Wu Xu Sun Zhu Ma Hu Guo Lin He Gao Liang Zheng Luo Song Xie Tang Han Cao Deng Xiao Feng Ceng Cheng Cai Peng Pan Yuan Dong Yu Su She Lu: Wei Jiang Tian Du Ding Chen/shen Fan Fu Zhong Lu Dai Cui Ren Liao Yao Fang Jin Qiu Jia Tan Gu Zou Dan Xiong Meng Qin Yan Xue Hou Lei Bai Long Duan Hao Kong Shao Shi Mao Chang Wan Lai Kang Yin Qian Niu Hong Gong)
    x[rand(x.size)]
  end

  # Returs a random email based on Chinese names
  def zh_lorem_email(replacement = nil)
    if replacement
      return replacement
    end

    # delimiters = ['_', '-', '']
    domains = %w(gmail.com yahoo.com.tw mail2000.com.tw mac.com example.com.tw ms42.hinet.net mail.notu.edu.tw)
    username = zh_lorem_first_name_pinyin + zh_lorem_last_name_pinyin
    "#{username}@#{domains[rand(domains.size)]}".downcase
  end

  SENTENCES = [['一個有年紀的人，', '一個較大的孩子說，', '一到夜裡，', '一到過年，', '一勺冰水，', '一夜的花費，', '一婦人說，', '一寸光陰一寸金，', '一年的設定，', '一時看鬧熱的人，', '一箇來往的禮節，', '一絲絲涼爽秋風，', '一綵綵霜痕，', '一邊的行列，', '一陣吶喊的聲浪，', '一顆銀亮亮的月球，', '一類的試筆詩，', '下半天的談判，', '不問是誰，', '不懷著危險的恐懼，', '不斷地逝去，', '不是容易就能奏功，', '不是有學士有委員，', '不是皆發了幾十萬，', '不曉得我的目的，', '不曉得誰創造的，', '不曉得順這機會，', '不用摸索，', '不知是兄哥或小弟，', '不知行有多少時刻，', '不知談論些什麼，', '不聲不響地，', '不股慄不內怯，', '不能成功，', '不能隨即回家，', '不要爭一爭氣，', '不論什麼階級的人，', '不讓星星的光明，', '不趕他出去，', '不遇著危險，', '不過隨意做作而已，', '不顧慮傍人，', '且新正閒著的時候，', '丙喝一喝茶，', '丙論辯似的說，', '丙驚疑地問，', '乙感嘆地說，', '乙接著嘴說，', '也不知什麼是方向，', '也因為地面的崎嶇，', '也就不容易，', '也就便宜，', '也就分外著急，', '也是不受後母教訓，', '也是不容易，', '也是經驗不到，', '也有他們一種曆，', '互有參差，', '互相信賴，', '互相提攜而前進，', '互相提攜，', '亦都出去了，', '人們不預承認，', '人們多不自量，', '人們怎地在心境上，', '人們的信仰，', '什麼樣子，', '他不和人家分擔，', '他倆不想到休息，', '他倆人中的一個，', '他倆便也攜著手，', '他倆感到有一種，', '他倆本無分別所行，', '他倆疲倦了，', '他們偏不採用，', '他們在平時，', '他叩了不少下頭，', '他的伴侶，', '他說人們是在發狂，', '他那麼盡力，', '他高興的時候，', '以樂其心志，', '任便人家笑罵，', '似也有稍遲緩，', '似報知人們，', '似皆出門去了，', '但在手面趁吃人，', '但現在的曆法，', '但這是所謂大勢，', '住在福戶內的人，', '何故世上的人類們，', '併也不見陶醉，', '使勞者們，', '使成粉末，', '來浪費有用的金錢，', '便說這卑怯的生命，', '保不定不鬧出事來，', '借著拜年的名目，', '做事業的人們，', '偷得空間，', '傳播到廣大空間去，', '像日本未來的時，', '像這樣子鬧下去，', '兄弟們到這樣時候，', '先先後後，', '光明已在前頭，', '全數花掉，', '典衫當被，', '再回到現實世界，', '再鬧下去，', '別地方是什麼樣子，', '到大街上玩去罷，', '刺腳的荊棘，', '剛纔經市長一說，', '務使春風吹來，', '包圍住這人世間，', '十五年前的熱鬧，', '卻不能稍超興奮，', '卻自甘心著，', '又有不可得的快樂，', '又有人不平地說，', '只些婦女們，', '只在我們貴地，', '只是前進，', '只有乘這履端初吉，', '只有前進，', '只有風先生的慇懃，', '只殘存些婦女小兒，', '可以借它的魔力，', '各個兒指手畫腳，', '各要爭個體面，', '同在這顆地球上，', '向面的所向，', '呻呻吟吟，', '和其哀情，', '和別的其餘的一日，', '和狺狺的狗吠，', '和純真的孩童們，', '和電柱上路燈，', '四城門的競爭，', '四方雲集，', '因一邊還都屬孩子，', '因為一片暗黑，', '因為市街的鬧熱日，', '因為所規定的過年，', '因為空間的黑暗，', '因為這是親戚間，', '團團地坐著，', '在一個晚上，', '在一處的客廳裡，', '在一邊誘惑我，', '在他們社會裡，', '在以前任怎地追憶，', '在做頭老的，', '在冷靜的街尾，', '在冷風中戰慄著，', '在和他們同一境遇，', '在幾千年前，', '在成堆的人們中，', '在我回憶裡，', '在我的知識程度裡，', '在煙縷繚繞的中間，', '在環繞太陽運轉，', '在這時候，', '在這樣黑暗之下，', '在這次血祭壇上，', '在這黑暗之中，', '在這黑暗統治之下，', '地方自治的權能，', '地球繞著太陽，', '多亂惱惱地熱鬧著，', '天體的現象嗎，', '失了伴侶的他，', '奉行正朔，', '好久已無聲響的雷，', '媽祖的靈應，', '孩子們回答著，', '孩子們得到指示，', '孩子們的事，', '孩子們辯說，', '孩子般的眼光，', '完全不同日子，', '完全打消了，', '家門有興騰的氣象，', '富豪是先天所賦與，', '實在也就難怪，', '實在可憐可恨，', '將腦髓裡驅逐，', '小子不長進，', '少年已去金難得，', '就一味地吶喊著，', '就可觸到金錢，', '就是那些文人韻士，', '就發達繁昌起來，', '就說不關什麼，', '居然宣佈了戰爭，', '已不成功了，', '已經準備下，', '已經財散人亡，', '已闢農場已築家室，', '平生慣愛咬文嚼字，', '店舖簷前的天燈，', '張開他得意的大口，', '強盛到肉體的增長，', '得了新的刺激，', '心裡不懷抱驚恐，', '忘卻了溪和水，', '忘記他的伴侶，', '快樂的追求，', '忽然地顛蹶，', '忽起眩暈，', '怕大家都記不起了，', '思想也漸糢糊起來，', '恍惚有這呼聲，', '悠揚地幾聲洞簫，', '想因為腳有些疲軟，', '愈會賺錢，', '愈要追尋快樂，', '愈覺得金錢的寶貴，', '意外地竟得生存，', '慢慢地說，', '憑我們有這一身，', '我不明白，', '我們是在空地上，', '我們有這雙腕，', '我們處在這樣環境，', '我在兒童時代，', '我的意見，', '我記得還似昨天，', '所以也不擔心到，', '所以家裡市上，', '所以窮的人，', '所以這一回，', '所以那邊的街市，', '所有一切，', '所有無謂的損失，', '所謂雪恥的競爭，', '所謂風家也者，', '手一插進衣袋，', '把她清冷冷的光輝，', '抵當賓客的使費，', '抹著一縷兩縷白雲，', '拔去了不少，', '捧出滿腔誠意，', '接著又說，', '接連鬥過兩三晚，', '握著有很大權威，', '揭破死一般的重幕，', '擋不住大的拳頭，', '放下茶杯，', '放不少鞭炮，', '放射到地平線以外，', '救死且沒有工夫，', '新年的一日，', '旗鼓的行列，', '既不能把它倆，', '日頭是自東徂西，', '早幾點鐘解決，', '春五正月，', '昨晚曾賜過觀覽，', '是不容有異議，', '是抱著滿腹的憤氣，', '是社會的一成員，', '是道路或非道路，', '是黑暗的晚上，', '時間的進行，', '暗黑的氣氛，', '有一陣孩子們，', '有什麼科派捐募，', '有時再往親戚家去，', '有最古的文明，', '有的孩子喊著，', '未嘗有人敢自看輕，', '某某和某等，', '樹要樹皮人要麵皮，', '橋柱是否有傾斜，', '橋梁是否有斷折，', '正可養成競爭心，', '死鴨子的嘴吧，', '比較兒童時代，', '汝算不到，', '沒有年歲，', '波湧似的，', '泰然前進，', '溪的廣闊，', '溺人的水窪，', '滾到了天半，', '漸被遮蔽，', '濛迷地濃結起來，', '無奈群眾的心裡，', '熱血正在沸騰，', '燈火星星地，', '現在不高興了，', '現在只有覺悟，', '現在想沒得再一個，', '現在的我，', '生性如此，', '生的糧食儘管豐富，', '由我的生的行程中，', '由深藍色的山頭，', '由著裊裊的晚風，', '由隘巷中走出來，', '甲微喟的說，', '甲憤憤地罵，', '甲興奮地說，', '略一對比，', '當科白尼還未出世，', '看我們現在，', '看見有幾次的變遷，', '看見鮮紅的血，', '眩眼一縷的光明，', '礙步的石頭，', '福戶內的事，', '禮義之邦的中國，', '究竟為的是什麼，', '笑掉了齒牙，', '第一浮上我的思想，', '筋肉比較的瘦弱，', '籠罩著街上的煙，', '精神上多有些緊張，', '約同不平者的聲援，', '統我的一生到現在，', '經過了很久，', '經過幾許途程，', '經驗過似的鄭重說，', '繞著亭仔腳柱，', '纔見有些白光，', '美惡竟不會分別，', '老人感慨地說，', '聽說市長和郡長，', '聽說有人在講和，', '聽說路關鐘鼓，', '能夠合官廳的意思，', '自己走出家來，', '自鳴得意，', '花去了幾千塊，', '花各人自己的錢，', '若會賺錢，', '草繩上插的香條，', '蔥惶回顧，', '行動上也有些忙碌，', '行行前進，', '街上看鬧熱的人，', '街上還是鬧熱，', '街上頓添一種活氣，', '被他們欺負了，', '被另一邊阻撓著，', '被風的歌唱所鼓勵，', '要損他一文，', '要是說一聲不肯，', '要趁節氣，', '親戚們多贊稱我，', '覺得分外悠遠，', '觸進人們的肌膚，', '試把這箇假定廢掉，', '說了不少好話，', '說什麼爭氣，', '說我乖巧識禮，', '說是沒有法子的事，', '誰都有義務分擔，', '議論已失去了熱烈，', '讓他獨自一個，', '走過了一段里程，', '身量雖然較高，', '輕輕放棄，', '輾轉運行，', '農民播種犁田，', '透過了衣衫，', '這一句千古名言，', '這一點不能明白，', '這些談論的人，', '這回在奔走的人，', '這天大的奇變，', '這幾聲呼喊，', '這澎湃聲中，', '這說是野蠻的慣習，', '這邊門口幾人，', '通溶化在月光裡，', '連哼的一聲亦不敢，', '連生意本，', '進來的人說，', '遂亦不受到阻礙，', '遂有人出來阻擋，', '過了些時，', '過年種種的預備，', '還是孱弱的可憐，', '還有閒時間，', '那三種曆法，', '那不知去處的前途，', '那些富家人，', '那時代的一年，', '那更不成問題，', '那末地球運行最初，', '那邊亭仔腳幾人，', '那邊有些人，', '都很讚成，', '金錢愈不能到手，', '金錢的問題，', '金錢的慾念，', '銅鑼響亮地敲起來，', '錢的可能性愈少，', '鑼的響聲，', '鑼聲亦不響了，', '阻斷爭論，', '除廢掉舊曆，', '陷人的泥澤，', '雖亦有人反對，', '雖則不知，', '雖受過欺負，', '雖未見到結論，', '雖遇有些顛蹶，', '雨太太的好意，', '音響的餘波，', '風雨又調和著節奏，', '驟然受到光的刺激，', '體軀支持不住了，', '鬧熱到了，', '鬧過別一邊去，'], ['一層層堆聚起來。', '不停地前進。', '不可讓他佔便宜。', '不教臉紅而已。', '不知橫亙到何處。', '丙可憐似的說。', '也須為著子孫鬥爭。', '互相提攜走向前去。', '亦不算壞。', '人類的一分子了。', '今夜是明月的良宵。', '他正在發瘋呢。', '何用自作麻煩。', '何須非議。', '便把眼皮睜開。', '兩方就各答應了。', '再鬧一回亦好。', '分辨出浩蕩的溪聲。', '卻自奉行唯謹。', '又一人說。', '和他們做新過年。', '和鍛鍊團結力。', '因為不高興了。', '在表示著歡迎。', '在閃爍地放亮。', '地方領導人。', '坐著閒談。', '多有一百倍以上。', '奏起悲壯的進行曲。', '嬉嬉譁譁地跑去了。', '將要千圓。', '導發反抗力的火戰。', '就再開始。', '就和解去。', '就在明后兩天。', '就是金錢。', '已像將到黎明之前。', '已無暇計較。', '忘卻了一切。', '怎麼就十五年了。', '愈會碰著痛苦。', '我去拿一面鑼來。', '捲下中街去。', '是算不上什麼。', '有些多事的人問。', '有人詰責似的問。', '本來是橫逆不過的。', '本該挨罵。', '漏射到地上。', '為著前進而前進。', '甲哈哈地笑著說。', '甲總不平地罵。', '看看又要到了。', '眼睛已失了作用。', '神所厭棄本無價值。', '移動自己的腳步。', '終也渡過彼岸。', '終是不可解的疑問。', '繞來穿去。', '繼續他們的行程。', '老人懷疑地問。', '街上實在繁榮極了。', '街上的孩子們在喊。', '被逐的前人之子。', '說得很高興似的。', '這原因就不容妄測。', '運行了一個週環。', '那就....。', '那痛苦就更難堪了。', '那邊比較鬧熱。', '險些兒跌倒。', '黃金難買少年心。'], ['一樣是歹命人！', '但是這一番啊！', '來--來！', '來和他們一拚！', '值得說什麼爭麵皮！', '兄弟們來！', '到城裡去啊！', '又受了他們一頓罵！', '和他們一拚！', '實在想不到！', '憑這一身！', '憑這雙腕！', '我要頂禮他啊！', '把我們龍頭割去！', '捨此一身和他一拚！', '明夜沒得再看啦！', '歲月真容易過！', '比狗還輸！', '無目的地前進！', '甘失掉了麵皮！', '盲目地前進！', '老不死的混蛋！', '趕快走下山去！', '這是如何地悲悽！', '這是如何的決意！', '那纔利害啦！']].freeze

  # Return one Chinese word (character)
  def zh_lorem_word(replacement = nil)
    zh_lorem_words(1, replacement)
  end

  # Return the required amount of words
  def zh_lorem_words(total, _replacement = nil)
    s = []
    while s.length < total
      x = random_one(SENTENCES[rand(3)])
      s << random_one(x.split(//u)[0..-2])
    end
    s.join('')
  end

  # Return exactly one sentence
  def zh_lorem_sentence(replacement = nil)
    if replacement
      return replacement
    end

    out = ''
    out += random_one(SENTENCES[0]) while rand(2) == 1
    out += random_one(SENTENCES[1 + rand(2)])
    out
  end

  # Return the required amount of sentences
  def zh_lorem_sentences(total, replacement = nil)
    out = ''
    (1..total).map { zh_lorem_sentence(replacement) }.join(out)
  end

  # Return exactly one paragraph of Chinese text
  def zh_lorem_paragraph(replacement = nil)
    if replacement
      return replacement
    end

    zh_lorem_paragraphs(1, replacement)
  end

  # Return the required amount of paragraphs of Chinese text, seperated by \n\n
  def zh_lorem_paragraphs(total, replacement = nil)
    if replacement
      return replacement
    end

    (1..total).map do
      zh_lorem_sentences(random_one(3..7), replacement)
    end.join("\n\n")
  end

  private

  def random_one(arr)
    arr.to_a[rand(arr.to_a.size)]
  end
end
