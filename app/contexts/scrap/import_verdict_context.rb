class Scrap::ImportVerdictContext < BaseContext
  before_perform  :build_analysis_context
  before_perform  :create_main_judge_by_highest, if: :is_highest_court?
  before_perform  :find_main_judge, unless: :is_highest_court?
  before_perform  :find_or_create_story
  before_perform  :build_verdict
  before_perform  :assign_default_value
  after_perform   :upload_file
  after_perform   :update_data_to_story
  after_perform   :update_adjudge_date
  after_perform   :create_relation_for_lawyer
  after_perform   :create_relation_for_judge
  after_perform   :create_relation_for_main_judge
  after_perform   :create_relation_for_defendant
  after_perform   :record_count_to_daily_notify

  class << self
    def perform(court, orginal_data, content, word, publish_date, stroy_type)
      new(court, orginal_data, content, word, publish_date, stroy_type).perform
    end
  end

  def initialize(court, orginal_data, content, word, publish_date, stroy_type)
    @court = court
    @orginal_data = orginal_data
    @content = content
    @word = word
    @publish_date = publish_date
    @stroy_type = stroy_type
  end

  def perform
    run_callbacks :perform do
      add_error("create date fail") unless @verdict.save
      @verdict
    end
  end

  private

  def build_analysis_context
    @analysis_context = Scrap::AnalysisVerdictContext.new(@content, @word)
  end

  def is_highest_court?
    @court.code == "TPS"
  end

  def find_main_judge
    branches = @court.branches.current.where("chamber_name LIKE ? ", "%#{@stroy_type}%")
    main_judges = branches.map{ |a| a.judge if a.judge.name == @analysis_context.main_judge_name }.compact.uniq
    @main_judge = main_judges.count == 1 ?  main_judges.last : nil

    unless main_judges.count == 1
      SlackService.notify_analysis_async("判決書關聯主審法官失敗 : 找到多位法官, 或者找不到任何法官\n 判決書類別 : #{@stroy_type}, 法官姓名 : #{@analysis_context.main_judge_name}, 法院 : #{@court.scrap_name}")
    end
  end

  def create_main_judge_by_highest
    @main_judge = Scrap::CreateJudgeByHighestCourtContext.new(@court, @analysis_context.main_judge_name).perform
  end

  def find_or_create_story
    array = @word.split(",")
    @story = Story.find_or_create_by(year: array[0], word_type: array[1], number: array[2], court: @court)
  end

  def build_verdict
    @verdict = Verdict.find_or_initialize_by(
      story: @story,
      main_judge: @main_judge,
      publish_date: @publish_date,
      main_judge_name: @analysis_context.main_judge_name,
      judges_names: @analysis_context.judges_names,
      prosecutor_names: @analysis_context.prosecutor_names,
      lawyer_names: @analysis_context.lawyer_names,
      defendant_names: @analysis_context.defendant_names
    )
  end

  def assign_default_value
    @verdict.assign_attributes(is_judgment: @analysis_context.is_judgment?)
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
      branches = @court.branches.current.where("chamber_name LIKE ? ", "%#{@stroy_type}%")
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

  def record_count_to_daily_notify
    Redis::Counter.new("daily_scrap_verdict_count").increment
  end
end
