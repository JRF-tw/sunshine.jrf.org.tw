class Scrap::AnalysisVerdictContext < BaseContext

  def initialize(verdict, verdict_content, verdict_word)
    @verdict = verdict
    @verdict_content = verdict_content
    @verdict_word = verdict_word
    @crawler_history = CrawlerHistory.find_or_create_by(crawler_on: Time.zone.today)
  end

  def main_judge_name
    matched = @verdict_content.match(/審判長法\s*官\s*([\p{Word}\w\s\S]*?)\n/)
    if matched
      return matched[1].squish.delete("\r").delete(' ')
    else
      Logs::AddCrawlerError.add_verdict_error(@crawler_history, @verdict, :parse_main_judge_empty, '取得 審判長法官 資訊為空')
      return nil
    end
  end

  def judges_names
    matched = @verdict_content.match(/^\s*法\s*官\s+([\p{Word}\w\s\S]*?)\n/)
    if matched
      return @verdict_content.scan(/^\s*法\s*官\s+([\p{Word}\w\s\S]*?)\n/).map { |i| i[0].squish.delete("\r").delete(' ') }
    else
      Logs::AddCrawlerError.add_verdict_error(@crawler_history, @verdict, :parse_judge_empty, '取得 法官 資訊為空')
      return []
    end
  end

  def prosecutor_names
    matched = @verdict_content.match(/檢察官(\p{Word}+)到庭執行職務/)
    if matched
      return @verdict_content.scan(/檢察官(\p{Word}+)到庭執行職務/).map { |i| i[0] }
    else
      Logs::AddCrawlerError.add_verdict_error(@crawler_history, @verdict, :parse_prosecutor_empty, '取得 檢察官 資訊為空')
      return []
    end
  end

  def lawyer_names
    matched = @verdict_content.squish.match(/\s+(\p{Word}+)律師/)
    if matched
      return @verdict_content.squish.scan(/\s+(\p{Word}+)律師/).map { |i| i[0] }
    else
      Logs::AddCrawlerError.add_verdict_error(@crawler_history, @verdict, :parse_lawyer_empty, '取得 律師 資訊為空')
      return []
    end
  end

  def party_names
    matched_mutiple_type = @verdict_content.squish.match(/\n\s*被\s+告\s+([\p{Word}\w\s\S]+?)\n\s*[\s男\s|\s女\s|上|訴訟|法定|選任|指定|輔\s+佐\s+人]/)
    matched = @verdict_content.squish.match(/被\s+告\s+(\p{Word}+)/)
    if matched_mutiple_type
      parties = @verdict_content.squish.scan(/\n\s*被\s+告\s+([\p{Word}\w\s\S]+?)\n\s*[\s男\s|\s女\s|上|訴訟|法定|選任|指定|輔\s+佐\s+人]/).map { |i| i[0] }
      parties = parties.join("\n")
      parties = parties.split(/\n+/).map(&:strip)
      return parties.uniq
    elsif matched
      return @verdict_content.squish.scan(/被\s+告\s+(\p{Word}+)/).map { |i| i[0] }
    else
      Logs::AddCrawlerError.add_verdict_error(@crawler_history, @verdict, :parse_party_empty, '取得 當事人 資訊為空')
      return []
    end
  end
end
