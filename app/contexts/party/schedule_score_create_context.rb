class Party::ScheduleScoreCreateContext < BaseContext
  PERMITS = [:court_id, :year, :word_type, :number, :story_type, :start_on,
             :confirmed_realdate, :judge_name, :note, :appeal_judge].freeze +
            ScheduleScore.stored_attributes[:attitude_scores]

  # before_perform :can_not_score
  before_perform :check_story
  before_perform :check_schedule
  before_perform :check_judge
  before_perform :check_attitude_scores
  before_perform :build_schedule_score
  before_perform :assign_attribute
  before_perform :get_scorer_ids
  before_perform :get_scored_story_ids
  after_perform  :auto_subscribe_story
  after_perform  :alert_story_by_party_scored_count
  after_perform  :alert_party_scored_story_count

  def initialize(party)
    @party = party
  end

  def perform(params)
    @params = permit_params(params[:schedule_score] || params, PERMITS)
    run_callbacks :perform do
      return add_error(:judge_already_scored) unless @schedule_score.save
      @schedule_score
    end
  end

  private

  def can_not_score
    # TODO : Block user
  end

  def check_story
    context = Party::CheckScheduleScoreInfoContext.new(@party)
    @story = context.perform(@params)
    return add_error(:story_not_found, context.error_messages.join(',')) unless @story
  end

  def check_schedule
    context = Party::CheckScheduleScoreDateContext.new(@party)
    @schedule = context.perform(@params)
    return add_error(:schedule_not_found, context.error_messages.join(',')) if context.has_error?
  end

  def check_judge
    context = Party::CheckScheduleScoreJudgeContext.new(@party)
    @judge = context.perform(@params)
    return add_error(:judge_not_found, context.error_messages.join(',')) unless @judge
  end

  def check_attitude_scores
    ScheduleScore.stored_attributes[:attitude_scores].each do |keys|
      return add_error(:attitude_scores_blank) unless @params[keys].present?
    end
    return false if has_error?
  end

  def build_schedule_score
    @schedule_score = @party.schedule_scores.new(@params)
  end

  def assign_attribute
    @schedule_score.assign_attributes(schedule: @schedule, judge: @judge, story: @story)
  end

  # TODO : alert need refactory, performance issue

  def get_scorer_ids
    schedule_scorer_ids = Story.find(@story.id).schedule_scores.where(schedule_rater_type: 'Party').map(&:schedule_rater_id)
    verdict_scorer_ids = Story.find(@story.id).verdict_scores.where(verdict_rater_type: 'Party').map(&:verdict_rater_id)
    @total_scorer_ids = (schedule_scorer_ids + verdict_scorer_ids).uniq
  end

  def get_scored_story_ids
    schedule_scored_story_ids = ScheduleScore.where(schedule_rater: @party).map(&:story_id)
    verdict_scored_story_ids = VerdictScore.where(verdict_rater: @party).map(&:story_id)
    @total_scored_story_ids = (schedule_scored_story_ids + verdict_scored_story_ids).uniq
  end

  def auto_subscribe_story
    Party::StorySubscriptionToggleContext.new(@story).perform(@party) unless @party.story_subscriptions.find_by(story_id: @story.id)
  end

  def alert_story_by_party_scored_count
    SlackService.notify_scored_time_over_range_alert("案件編號 #{@story.id} 同一案件，參與評鑑的「當事人人數」超過 #{Story::MAX_PARTY_SCORED_COUNT} 人") if @total_scorer_ids.count >= Story::MAX_PARTY_SCORED_COUNT && !@total_scorer_ids.include?(@party.id)
  end

  def alert_party_scored_story_count
    SlackService.notify_scored_time_over_range_alert("當事人 #{@party.name} 已評鑑超過超過 #{Party::MAX_SCORED_COUNT}") if @total_scored_story_ids.count >= Party::MAX_SCORED_COUNT && !@total_scored_story_ids.include?(@story.id)
  end
end
