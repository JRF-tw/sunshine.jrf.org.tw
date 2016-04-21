class Scrap::ImportVerdictContext < BaseContext
  before_perform :parse_orginal_data
  before_perform :parse_nokogiri_data
  before_perform :build_analysis_context
  before_perform :find_or_create_story
  before_perform :build_verdict
  after_perform  :upload_file

  def initialize(import_data, court)
    @import_data = import_data
    @court = court
  end

  def perform
    run_callbacks :perform do
      add_error("create date fail") unless @verdict.save
      @verdict
    end
  end

  private

  def parse_orginal_data
    @orginal_data = @import_data.body.force_encoding("UTF-8")
  end

  def parse_nokogiri_data
    @nokogiri_data = Nokogiri::HTML(@import_data.body)
  end

  def verdict_word
    @nokogiri_data.css("table")[4].css("tr")[0].css("td")[1].text
  end

  def verdict_content
    @nokogiri_data.css("pre").text
  end

  def build_analysis_context
    @analysis_context = Scrap::AnalysisVerdictContext.new(verdict_content)
  end

  def find_or_create_story
    array = verdict_word.split(",")
    @story = Story.find_or_create_by(year: array[0], word_type: array[1], number: array[2], court: @court)
  end

  def build_verdict
    @verdict = Verdict.new(
      content: verdict_content,
      story: @story,
      is_judgment: @analysis_context.is_judgment?,
      judges_names: @analysis_context.judges_names,
      prosecutor_names: @analysis_context.prosecutor_names,
      lawyer_names: @analysis_context.lawyer_names,
      defendant_names: @analysis_context.defendant_names
    )
  end

  def upload_file
    Scrap::UploadVerdictContext.new(@orginal_data).perform(@verdict)
  end
end
