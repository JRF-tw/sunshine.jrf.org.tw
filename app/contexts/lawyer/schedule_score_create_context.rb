class Lawyer::ScheduleScoreCreateContext < BaseContext
  PERMITS = [:court_id, :year, :word_type, :number, :date, :confirmed_realdate, :judge_name, :command_score, :attitude_score, :note, :appeal_judge].freeze

  # before_perform :can_not_score
  before_perform :check_command_score
  before_perform :check_attitude_score
  before_perform :check_story
  before_perform :check_schedule
  before_perform :check_judge
  before_perform :build_schedule_score
  before_perform :assign_attribute
  before_perform :get_scorer_ids
  before_perform :get_scored_story_ids
  after_perform  :alert_story_by_lawyer_scored_count
  after_perform  :alert_lawyer_scored_story_count

  def initialize(lawyer)
    @lawyer = lawyer
  end

  def perform(params)
    @params = permit_params(params[:schedule_score] || params, PERMITS)
    run_callbacks :perform do
      return add_error(:data_create_fail, "開庭已經評論") unless @schedule_score.save
      @schedule_score
    end
  end

  private

  def can_not_score
    # TODO : Block user
  end

  def check_command_score
    return add_error(:data_blank, "訴訟指揮分數為必填") unless @params[:command_score].present?
  end

  def check_attitude_score
    # TODO : check score type attitude_score & rating_score
    return add_error(:data_blank, "開庭滿意度分數為必填") unless @params[:attitude_score].present?
  end

  def check_story
    context = Lawyer::CheckScheduleScoreInfoContext.new(@lawyer)
    @story = context.perform(@params)
    return add_error(:data_blank, context.error_messages.join(",")) unless @story
  end

  def check_schedule
    @schedule = Lawyer::CheckScheduleScoreDateContext.new(@lawyer).perform(@params)
  end

  def check_judge
    @judge = Lawyer::CheckScheduleScoreJudgeContext.new(@lawyer).perform(@params)
  end

  def build_schedule_score
    @schedule_score = @lawyer.schedule_scores.new(@params)
  end

  def assign_attribute
    @schedule_score.assign_attributes(schedule: @schedule, judge: @judge, story: @story)
  end

  # TODO : alert need refactory, performance issue

  def get_scorer_ids
    schedule_scorer_ids = Story.includes(:schedule_scores).find(@story.id).schedule_scores.where(schedule_rater_type: "Lawyer").map(&:schedule_rater_id)
    verdict_scorer_ids = Story.includes(:verdict_scores).find(@story.id).verdict_scores.where(verdict_rater_type: "Lawyer").map(&:verdict_rater_id)
    @total_scorer_ids = (schedule_scorer_ids + verdict_scorer_ids).uniq
  end

  def get_scored_story_ids
    schedule_scored_story_ids = ScheduleScore.where(schedule_rater: @lawyer).map(&:story_id)
    verdict_scored_story_ids = VerdictScore.where(verdict_rater: @lawyer).map(&:story_id)
    @total_scored_story_ids = (schedule_scored_story_ids + verdict_scored_story_ids).uniq
  end

  def alert_story_by_lawyer_scored_count
    SlackService.notify_scored_time_alert("案件編號 #{@story.id} 同一案件，參與評鑑的「律師人數」超過 #{Story::MAX_LAWYER_SCORED_COUNT} 人") if @total_scorer_ids.count >= Story::MAX_LAWYER_SCORED_COUNT && !@total_scorer_ids.include?(@lawyer.id)
  end

  def alert_lawyer_scored_story_count
    SlackService.notify_scored_time_alert("律師 #{@lawyer.name} 已評鑑超過超過 #{Lawyer::MAX_SCORED_COUNT}") if @total_scored_story_ids.count >= Lawyer::MAX_SCORED_COUNT && !@total_scored_story_ids.include?(@story.id)
  end
end
