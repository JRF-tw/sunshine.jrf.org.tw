class Party::ScheduleScoreCreateContext < BaseContext
  PERMITS = [:court_id, :year, :word_type, :number, :date, :confirmed_realdate, :judge_name, :rating_score, :note, :appeal_judge].freeze
  STORY_SCORED_COUNT = 3
  PARTY_SCORED_COUNT = 3

  # before_perform :can_not_score
  before_perform :check_rating_score
  before_perform :check_story
  before_perform :check_schedule
  before_perform :check_judge
  before_perform :build_schedule_score
  before_perform :assign_attribute
  after_perform  :alert_story_by_party_scored_count
  after_perform  :alert_party_scored_story_count

  def initialize(party)
    @party = party
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

  def check_rating_score
    return add_error(:data_blank, "開庭滿意度分數為必填") unless @params[:rating_score].present?
  end

  def check_story
    @story = Party::CheckScheduleScoreInfoContext.new(@party).perform(@params)
  end

  def check_schedule
    @schedule = Party::CheckScheduleScoreDateContext.new(@party).perform(@params)
  end

  def check_judge
    @judge = Party::CheckScheduleScoreJudgeContext.new(@party).perform(@params)
  end

  def build_schedule_score
    @schedule_score = @party.schedule_scores.new(@params)
  end

  def assign_attribute
    @schedule_score.assign_attributes(schedule: @schedule, judge: @judge, story: @story)
  end

  # TODO : alert need refactory, performance issue

  def alert_story_by_party_scored_count
    schedule_scorer_ids = Story.includes(:schedule_scores).find(@story.id).schedule_scores.where(schedule_rater_type: "Party").map(&:schedule_rater_id)
    verdict_scorer_ids = Story.includes(:verdict_scores).find(@story.id).verdict_scores.where(verdict_rater_type: "Party").map(&:verdict_rater_id)
    total_count = (schedule_scorer_ids + verdict_scorer_ids).uniq.count
    SlackService.notify_scored_time_alert("案件編號 #{@story.id} 同一案件，參與評鑑的「當事人人數」超過 #{Story::MAX_PARTY_SCORED_COUNT} 人") if total_count > Story::MAX_PARTY_SCORED_COUNT
  end

  def alert_party_scored_story_count
    schedule_scored_ids = ScheduleScore.where(schedule_rater: @party).map(&:story_id)
    verdict_scored_ids = VerdictScore.where(verdict_rater: @party).map(&:story_id)
    total_count = (schedule_scored_ids + verdict_scored_ids).uniq.count
    SlackService.notify_scored_time_alert("當事人 #{@party.name} 已評鑑超過超過 #{Party::MAX_SCORED_COUNT}") if total_count > Party::MAX_SCORED_COUNT
  end
end
