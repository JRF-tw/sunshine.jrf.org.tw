class Lawyer::VerdictScoreCreateContext < BaseContext
  PERMITS = [:court_id, :year, :word_type, :number, :judge_name, :quality_score, :note, :appeal_judge].freeze
  STORY_SCORED_COUNT = 3
  LAWYER_SCORED_COUNT = 3

  # before_perform :can_not_score
  before_perform :check_quality_score
  before_perform :check_story
  before_perform :check_judge
  before_perform :build_verdict_score
  before_perform :assign_attribute
  after_perform  :record_story_verdict_scored_count
  after_perform  :record_lawyer_verdict_scored_count

  def initialize(lawyer)
    @lawyer = lawyer
  end

  def perform(params)
    @params = permit_params(params[:verdict_score] || params, PERMITS)
    run_callbacks :perform do
      return add_error(:data_create_fail, "開庭已經評論") unless @verdict_score.save
      @verdict_score
    end
  end

  private

  def can_not_score
    # TODO : Block user
  end

  def check_quality_score
    return add_error(:date_blank, "訴訟指揮分數為必填") unless @params[:quality_score].present?
  end

  def check_story
    @story = Lawyer::VerdictScoreCheckInfoContext.new(@lawyer).perform(@params)
  end

  def check_judge
    @judgement = Lawyer::VerdictScoreCheckJudgeContext.new(@lawyer).perform(@params)
  end

  def build_verdict_score
    @verdict_score = @lawyer.verdict_scores.new(@params)
  end

  def assign_attribute
    @verdict_score.assign_attributes(story: @story, judge: @judgement ? @judgement.main_judge : nil)
  end

  def record_story_verdict_scored_count
    SlackService.notify_scored_time_alert("案件編號 #{@story.id} 已超過被評鑑最大值") if @story.verdict_scored_count.increment >= STORY_SCORED_COUNT
  end

  def record_lawyer_verdict_scored_count
    SlackService.notify_scored_time_alert("律師 #{@lawyer.name} 已超過評鑑判決最大值") if @lawyer.verdict_scored_count.increment >= LAWYER_SCORED_COUNT
  end
end
