module Scrap::Concerns::AnalysisVerdictContent
  extend ActiveSupport::Concern

  def parse_main_judge_name(verdict, content, crawler_history)
    matched = content.match(/審判長法\s*官\s*([\p{Word}\w\s\S]*?)\n/)
    if matched
      return matched[1].squish.delete("\r").delete(' ')
    else
      Logs::AddCrawlerError.add_verdict_error(crawler_history, verdict, :parse_main_judge_empty, '取得 審判長法官 資訊為空')
      return nil
    end
  end

  def parse_judges_names(verdict, content, crawler_history)
    matched = content.match(/法\s*官\s+([\p{Word}\w\s\S]*?)\n/)
    if matched
      return content.scan(/法\s*官\s+([\p{Word}\w\s\S]*?)\n/).map { |i| i[0].squish.delete("\r").delete(' ') }
    else
      Logs::AddCrawlerError.add_verdict_error(crawler_history, verdict, :parse_judge_error, '爬取法官格式錯誤, 撈取為空') if content =~ /法官/
      Logs::AddCrawlerError.add_verdict_error(crawler_history, verdict, :parse_judge_not_exist, '判決書上沒有法官') unless content =~ /法官/
      return []
    end
  end

  def parse_prosecutor_names(verdict, content, crawler_history)
    matched = content.match(/檢察官(\p{Word}+)到庭執行職務/)
    if matched
      return content.scan(/檢察官(\p{Word}+)到庭執行職務/).map { |i| i[0] }
    else
      Logs::AddCrawlerError.add_verdict_error(crawler_history, verdict, :parse_prosecutor_error, '爬取檢察官格式錯誤, 撈取為空') if content =~ /檢察官/
      Logs::AddCrawlerError.add_verdict_error(crawler_history, verdict, :parse_prosecutor_not_exist, '判決書上沒有檢察官') unless content =~ /檢察官/
      return []
    end
  end

  def parse_lawyer_names(verdict, content, crawler_history)
    matched = content.squish.match(/\s+(\p{Word}+)律師/)
    if matched
      return content.squish.scan(/\s+(\p{Word}+)律師/).map { |i| i[0] }
    else
      Logs::AddCrawlerError.add_verdict_error(crawler_history, verdict, :parse_lawyer_error, '爬取律師格式錯誤, 撈取為空') if content =~ /律師/
      Logs::AddCrawlerError.add_verdict_error(crawler_history, verdict, :parse_lawyer_not_exist, '判決書上沒有律師') unless content =~ /律師/
      return []
    end
  end

  def parse_party_names(verdict, content, crawler_history)
    matched_mutiple_type = content.squish.match(/\n\s*被\s+告\s+([\p{Word}\w\s\S]+?)\n\s*[\s男\s|\s女\s|上|訴訟|法定|選任|指定|輔\s+佐\s+人]/)
    matched = content.squish.match(/被\s+告\s+(\p{Word}+)/)
    if matched_mutiple_type
      parties = content.squish.scan(/\n\s*被\s+告\s+([\p{Word}\w\s\S]+?)\n\s*[\s男\s|\s女\s|上|訴訟|法定|選任|指定|輔\s+佐\s+人]/).map { |i| i[0] }
      parties = parties.join("\n")
      parties = parties.split(/\n+/).map(&:strip)
      return parties.uniq
    elsif matched
      return content.squish.scan(/被\s+告\s+(\p{Word}+)/).map { |i| i[0] }
    else
      Logs::AddCrawlerError.add_verdict_error(crawler_history, verdict, :parse_party_error, '爬取當事人格式錯誤, 撈取為空')
      return []
    end
  end
end
