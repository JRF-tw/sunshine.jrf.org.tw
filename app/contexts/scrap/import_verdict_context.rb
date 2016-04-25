class Scrap::ImportVerdictContext < BaseContext
  before_perform :parse_orginal_data
  before_perform :parse_nokogiri_data
  before_perform :build_analysis_context
  before_perform :find_or_create_story
  before_perform :build_verdict
  after_perform  :upload_file
  after_perform  :sync_analysis_data

  def initialize(import_data, court)
    @import_data = import_data
    @court = court
  end

  def perform
    run_callbacks :perform do
      add_error("create date fail") unless @verdict.save
      @verdict
    end
  rescue => e
    SlackService.notify_async("判決書匯入失敗:  #{e.message}", channel: "#scrap_notify", name: "bug")
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

  def sync_analysis_data
    @story.assign_attributes(judges_names: (@story.judges_names + @analysis_context.judges_names).uniq)
    @story.assign_attributes(prosecutor_names: (@story.prosecutor_names + @analysis_context.prosecutor_names).uniq)
    @story.assign_attributes(lawyer_names: (@story.lawyer_names + @analysis_context.lawyer_names).uniq)
    @story.assign_attributes(defendant_names: (@story.defendant_names + @analysis_context.defendant_names).uniq)
    @story.save
  end
end
