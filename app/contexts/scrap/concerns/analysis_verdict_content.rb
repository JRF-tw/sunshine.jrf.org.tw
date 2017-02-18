module Scrap::Concerns::AnalysisVerdictContent
  extend ActiveSupport::Concern

  MAIN_JUDGE = /審判長法\s*官\s*([\p{Word}\w\s\S]*?)\n/
  JUDGE = /法\s*官[^\r\n]\s+([\p{Word}\w\s]*?)\n/
  PROSECUTOR = /檢察官(\p{Word}+)到庭執行職務/
  LAWYER = /\s+(\p{Word}+)律師/
  MUTI_TYPE_PARTY = /\n\s*被\s+告\s+([\p{Word}\w\s\S]+?)\n\s*[\s男\s|\s女\s|上|訴訟|法定|選任|指定|輔\s+佐\s+人]/
  PARTY = /被\s+告\s+(\p{Word}+)/
  HAS_JUDGES = /法官/
  HAS_PROSECUTOR = /檢察官/
  HAS_LAWYER = /律師/
  MAIN_ROLE = ["代\s*表\s*人", "上\s*訴\s*人", "聲\s*請\s*人", "受\s*刑\s*人", "抗\s*告\s*人", "公\s*訴\s*人", "選\s*任\s*辯\s*護\s*人", "被\s*告", "共\s*同", "再\s*抗\s*告\s*人", "兼\s*代\s*表\s*人", "上\s*一\s*被\s*告"].freeze
  SUB_ROLE = ["即\s*再\s*審\s*聲\s*請\s*人", "即\s*受\s*刑\s*人", "即\s*受\s*判\s*決\s*人", "即\s*被\s*告", "選\s*任\s*辯\s*護\s*人"].freeze

  def parse_main_judge_name(verdict, content, crawler_history)
    matched = content.match(MAIN_JUDGE)
    if matched
      return matched[1].squish.delete("\r").delete(' ')
    else
      Logs::AddCrawlerError.add_verdict_error(crawler_history, verdict, :parse_main_judge_empty, '取得 審判長法官 資訊為空')
      return nil
    end
  end

  def parse_judges_names(verdict, content, crawler_history)
    matched = content.match(JUDGE)
    if matched
      return content.scan(JUDGE).map { |i| i[0].squish.delete("\r").delete(' ') }
    else
      Logs::AddCrawlerError.add_verdict_error(crawler_history, verdict, :parse_judge_error, '爬取法官格式錯誤, 撈取為空') if content =~ HAS_JUDGES
      Logs::AddCrawlerError.add_verdict_error(crawler_history, verdict, :parse_judge_not_exist, '判決書上沒有法官') unless content =~ HAS_JUDGES
      return []
    end
  end

  def parse_prosecutor_names(verdict, content, crawler_history)
    matched = content.match(PROSECUTOR)
    if matched
      return content.scan(PROSECUTOR).map { |i| i[0] }
    else
      Logs::AddCrawlerError.add_verdict_error(crawler_history, verdict, :parse_prosecutor_error, '爬取檢察官格式錯誤, 撈取為空') if content =~ HAS_PROSECUTOR
      Logs::AddCrawlerError.add_verdict_error(crawler_history, verdict, :parse_prosecutor_not_exist, '判決書上沒有檢察官') unless content =~ HAS_PROSECUTOR
      return []
    end
  end

  def parse_lawyer_names(verdict, content, crawler_history)
    matched = content.squish.match(LAWYER)
    if matched
      return content.squish.scan(LAWYER).map { |i| i[0] }
    else
      Logs::AddCrawlerError.add_verdict_error(crawler_history, verdict, :parse_lawyer_error, '爬取律師格式錯誤, 撈取為空') if content =~ HAS_LAWYER
      Logs::AddCrawlerError.add_verdict_error(crawler_history, verdict, :parse_lawyer_not_exist, '判決書上沒有律師') unless content =~ HAS_LAWYER
      return []
    end
  end

  def parse_party_names(verdict, content, crawler_history)
    matched_mutiple_type = content.squish.match(MUTI_TYPE_PARTY)
    matched = content.squish.match(PARTY)
    if matched_mutiple_type
      parties = content.squish.scan(MUTI_TYPE_PARTY).map { |i| i[0] }
      parties = parties.join("\n")
      parties = parties.split(/\n+/).map(&:strip)
      return parties.uniq
    elsif matched
      return content.squish.scan(PARTY).map { |i| i[0] }
    else
      Logs::AddCrawlerError.add_verdict_error(crawler_history, verdict, :parse_party_error, '爬取當事人格式錯誤, 撈取為空')
      return []
    end
  end

  def parse_roles_hash(verdict, content, crawler_history)
    role_hash = {}
    end_point = content.index('上列')
    data = content.tr('　', ' ')[0..end_point - 1][/(?<=號)(.|\n)+/]
    role_array = data.scan(/(#{MAIN_ROLE.join('|')}){1}[\s]*(#{SUB_ROLE.join('|')})?(\s+\p{han}+)((\r\n\s{6}\p{han}+)*)/)
    role_array.each do |a|
      title = a[0..1].join.delete(' ')
      names = a[2..-1].join.squish.split(' ').uniq
      role_hash[title].present? ? role_hash[title] += names : role_hash[title] = names
    end
    Logs::AddCrawlerError.add_verdict_error(crawler_history, verdict, :parse_verdict_role_error, '爬取判決角色錯誤, 撈取為空') unless role_hash.present?
    role_hash
  end
end
