class Scrap::ImportVerdictContext < BaseContext
  before_perform :parse_orginal_data
  before_perform :parse_nokogiri_data
  before_perform :parse_verdict_stroy_type
  before_perform :parse_verdict_word
  before_perform :parse_verdict_content
  before_perform :build_analysis_context
  before_perform :find_main_judge
  before_perform :find_or_create_story
  before_perform :build_verdict
  after_perform  :upload_file
  after_perform  :update_data_to_story
  after_perform  :update_adjudge_date
  after_perform  :create_relation_for_lawyer
  after_perform  :create_relation_for_judge
  after_perform  :create_relation_for_main_judge
  after_perform  :create_relation_for_defendant

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
  rescue => e
    SlackService.scrap_notify_async("判決書分析資料失敗: parse_orginal_data處理資料為空\n import_data : #{@import_data}\n #{e.message}")
  end

  def parse_nokogiri_data
    @nokogiri_data = Nokogiri::HTML(@import_data.body)
  rescue => e
    SlackService.scrap_notify_async("判決書分析資料失敗: parse_nokogiri_data處理資料為空\n import_data : #{@import_data}\n #{e.message}")
  end

  def parse_verdict_stroy_type
    @verdict_stroy_type = @nokogiri_data.css("table")[0].css("b").text.match(/\s+(\p{Word}+)類/)[1]
  rescue => e
    SlackService.scrap_notify_async("判決書分析資料失敗: parse_nokogiri_data處理資料為空\n import_data : #{@import_data}\n #{e.message}")
  end

  def parse_verdict_word
    @verdict_word = @nokogiri_data.css("table")[4].css("tr")[0].css("td")[1].text
  rescue => e
    SlackService.scrap_notify_async("判決書分析資料失敗: parse_verdict_word處理資料為空\n nokogiri_data : #{@nokogiri_data}\n #{e.message}")
  end

  def parse_verdict_content
    @verdict_content = @nokogiri_data.css("pre").text
  rescue => e
    SlackService.scrap_notify_async("判決書分析資料失敗: parse_verdict_content處理資料為空\n nokogiri_data : #{@nokogiri_data}\n #{e.message}")
  end

  def build_analysis_context
    @analysis_context = Scrap::AnalysisVerdictContext.new(@verdict_content, @verdict_word)
  end

  def find_main_judge
    branches = @court.branches.where("chamber_name LIKE ? ", "%#{@verdict_stroy_type}%")
    main_judges = branches.map{ |a| a.judge if a.judge.name == @analysis_context.main_judge_name }.compact.uniq
    @main_judge = main_judges.count == 1 ?  main_judges.last : nil

    unless main_judges.count == 1
      SlackService.analysis_notify_async("判決書關聯主審法官失敗 : 找到多位法官, 或者找不到任何法官\n 判決書類別 : #{@verdict_stroy_type}, 法官姓名 : #{@analysis_context.main_judge_name}, 法院 : #{@court.full_name}")
    end
  end

  def find_or_create_story
    array = @verdict_word.split(",")
    @story = Story.find_or_create_by(year: array[0], word_type: array[1], number: array[2], court: @court)
  end

  def build_verdict
    @verdict = Verdict.new(
      story: @story,
      main_judge: @main_judge,
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

  def update_data_to_story
    @story.assign_attributes(judges_names: (@story.judges_names + @verdict.judges_names).uniq)
    @story.assign_attributes(prosecutor_names: (@story.prosecutor_names + @verdict.prosecutor_names).uniq)
    @story.assign_attributes(lawyer_names: (@story.lawyer_names + @verdict.lawyer_names).uniq)
    @story.assign_attributes(defendant_names: (@story.defendant_names + @verdict.defendant_names).uniq)
    @story.assign_attributes(main_judge: @main_judge) if @main_judge
    @story.assign_attributes(is_adjudge: @verdict.is_judgment?) if @verdict.is_judgment? && !@story.is_adjudge
    @story.save
  end

  def update_adjudge_date
    return unless @analysis_context.is_judgment?
    @story.update_attributes(adjudge_date: Date.today) unless @story.adjudge_date
    @verdict.update_attributes(adjudge_date: Date.today)
  end

  def create_relation_for_lawyer
    @verdict.lawyer_names.each do |name|
      lawyers = Lawyer.where(name: name)
      if lawyers.count == 1
        @verdict.lawyer_verdicts.create(lawyer: lawyers.first)
        StoryRelationCreateContext.new(@story).perform(name)
      end
    end
  end

  def create_relation_for_judge
    @verdict.judges_names.each do |name|
      branches = @court.branches.where("chamber_name LIKE ? ", "%#{@verdict_stroy_type}%")
      judges = branches.map{ |a| a.judge if a.judge.name == name }.compact.uniq
      if judges.count == 1
        @verdict.judge_verdicts.create(judge: judges.first)
        StoryRelationCreateContext.new(@story).perform(name)
      end
    end
  end

  def create_relation_for_main_judge
    StoryRelationCreateContext.new(@story).perform(@verdict.main_judge.name) if @verdict.main_judge
  end

  def create_relation_for_defendant
    @verdict.defendant_names.each do |name|
      defendants = Defendant.where(name: name)
      if defendants.count == 1
        @verdict.defendant_verdicts.create(defendant: defendants.first)
        StoryRelationCreateContext.new(@story).perform(name)
      end
    end
  end
end
