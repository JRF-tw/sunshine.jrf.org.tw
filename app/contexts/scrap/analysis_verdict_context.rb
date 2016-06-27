class Scrap::AnalysisVerdictContext < BaseContext

  def initialize(verdict_content, verdict_word)
    @verdict_content = verdict_content
    @verdict_word = verdict_word
  end

  def is_judgment?
    return @verdict_content.split.first.match(/判決/).present?
  end

  def main_judge_name
    matched = @verdict_content.match(/審判長法\s*官\s*([\p{Word}\w\s\S]*?)\n/)
    if matched
      return matched[1].squish.gsub("\r", "").gsub(" ", "")
    else
      SlackService.notify_analysis_async("裁判字號 : #{@verdict_word}, 取得 審判長法官 資訊為空") if is_judgment?
      return nil
    end
  end

  def judges_names
    matched = @verdict_content.match(/^\s*法\s*官\s+([\p{Word}\w\s\S]*?)\n/)
    if matched
      return @verdict_content.scan(/^\s*法\s*官\s+([\p{Word}\w\s\S]*?)\n/).map { |i| i[0].squish.gsub("\r", "").gsub(" ", "") }
    else
      SlackService.notify_analysis_async("裁判字號 : #{@verdict_word}, 取得 法官 資訊為空") if is_judgment?
      return []
    end
  end

  def prosecutor_names
    matched = @verdict_content.match(/檢察官(\p{Word}+)到庭執行職務/)
    if matched
      return @verdict_content.scan(/檢察官(\p{Word}+)到庭執行職務/).map { |i| i[0] }
    else
      SlackService.notify_analysis_async("裁判字號 : #{@verdict_word}, 取得 檢察官 資訊為空") if is_judgment?
      return []
    end
  end

  def lawyer_names
    matched = @verdict_content.squish.match(/\s+(\p{Word}+)律師/)
    if matched
      return @verdict_content.squish.scan(/\s+(\p{Word}+)律師/).map { |i| i[0] }
    else
      SlackService.notify_analysis_async("裁判字號 : #{@verdict_word}, 取得 律師 資訊為空") if is_judgment?
      return []
    end
  end

  def party_names
    matched_mutiple_type = @verdict_content.squish.match(/\n\s*被\s+告\s+([\p{Word}\w\s\S]+?)\n\s*[\s男\s|\s女\s|上|訴訟|法定|選任|指定|輔\s+佐\s+人]/)
    matched = @verdict_content.squish.match(/被\s+告\s+(\p{Word}+)/)
    if matched_mutiple_type
      parties = @verdict_content.squish.scan(/\n\s*被\s+告\s+([\p{Word}\w\s\S]+?)\n\s*[\s男\s|\s女\s|上|訴訟|法定|選任|指定|輔\s+佐\s+人]/).map { |i| i[0] }
      parties = parties.join("\n")
      parties = parties.split(/\n+/).map { |i| i.strip }
      return parties.uniq
    elsif matched
      return @verdict_content.squish.scan(/被\s+告\s+(\p{Word}+)/).map { |i| i[0] }
    else
      SlackService.notify_analysis_async("裁判字號 : #{@verdict_word}, 取得 當事人 資訊為空") if is_judgment?
      return []
    end
  end
end
