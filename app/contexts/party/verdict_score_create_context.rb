class Party::VerdictScoreCreateContext < BaseContext
  PERMITS = [:court_id, :year, :word_type, :number, :judge_name, :rating_score, :note, :appeal_judge].freeze
  STORY_SCORED_COUNT = 3
  PARTY_SCORED_COUNT = 3

  # before_perform :can_not_score
  before_perform :check_rating_score
  before_perform :check_story
  before_perform :check_judge
  before_perform :build_verdict_score
  before_perform :find_judgment
  before_perform :assign_attribute
  after_perform  :record_story_verdict_scored_count
  after_perform  :record_party_verdict_scored_count

  def initialize(party)
    @party = party
  end

  def perform(params)
    @params = permit_params(params[:verdict_score] || params, PERMITS)
    run_callbacks :perform do
      return add_error(:data_create_fail, "案件判決已經評論") unless @verdict_score.save
      @verdict_score
    end
  end

  private

  def can_not_score
    # TODO : Block user
  end

  def check_rating_score
    return add_error(:data_blank, "裁判滿意度為必填") unless @params[:rating_score].present?
  end

  def check_story
    @story = Party::VerdictScoreCheckInfoContext.new(@party).perform(@params)
  end

  def check_judge
    @judgment = Party::VerdictScoreCheckJudgeContext.new(@party).perform(@params)
  end

  def build_verdict_score
    @verdict_score = @party.verdict_scores.new(@params)
  end

  def find_judgment
    @judgment = @story.judgment_verdict.try(:last)
  end

  def assign_attribute
    @verdict_score.assign_attributes(story: @story, judge: @judgment ? @judgment.main_judge : nil)
  end

  def record_story_verdict_scored_count
    SlackService.notify_scored_time_alert("案件編號 #{@story.id} 已超過被評鑑最大值") if @story.verdict_scored_count.increment >= STORY_SCORED_COUNT
  end

  def record_party_verdict_scored_count
    SlackService.notify_scored_time_alert("律師 #{@party.name} 已超過評鑑判決最大值") if @party.verdict_scored_count.increment >= PARTY_SCORED_COUNT
  end
end
