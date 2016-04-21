class Scrap::AnalysisVerdictContext < BaseContext

  def initialize(content)
    @content = content
  end

  def is_judgment?
    return @content.match(/判決/).present?
  end

  def judges_names
    return @content.scan(/法\s+官\s+([\p{Word}\w\s\S]+?)\n/).map { |i| i[0].gsub("\r", '')  }
  end

  def prosecutor_names
    return @content.scan(/檢察官(\p{Word}+)到庭執行職務/).map { |i| i[0] }
  end

  def lawyer_names
    return @content.squish.scan(/\s+(\p{Word}+)律師/).map { |i| i[0] }
  end

  def defendant_names
    if @content.squish.match(/\n\s*被\s+告\s+([\p{Word}\w\s\S]+?)\n\s*[\s男\s|\s女\s|上|訴訟|法定|選任|指定|輔\s+佐\s+人]/)
      defendants = @content.squish.scan(/\n\s*被\s+告\s+([\p{Word}\w\s\S]+?)\n\s*[\s男\s|\s女\s|上|訴訟|法定|選任|指定|輔\s+佐\s+人]/).map { |i| i[0] }
      defendants = defendants.join("\n")
      defendants = defendants.split(/\n+/).map { |i| i.strip }
      return defendants.uniq
    elsif @content.squish.match(/被\s+告\s+(\p{Word}+)/)
      return @content.squish.scan(/被\s+告\s+(\p{Word}+)/).map { |i| i[0] }
    else
      return []
    end
  end
end
