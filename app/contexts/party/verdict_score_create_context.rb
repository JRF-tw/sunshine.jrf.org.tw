class Party::VerdictScoreCreateContext < BaseContext
  PERMITS = [:court_id, :year, :word_type, :number, :story_type, :judge_name, :rating_score, :note, :appeal_judge].freeze

  # before_perform :can_not_score
  before_perform :check_story
  before_perform :check_rating_score
  before_perform :build_verdict_score
  before_perform :assign_attribute
  before_perform :get_scorer_ids
  before_perform :get_scored_story_ids
  after_perform  :alert_story_by_party_scored_count
  after_perform  :alert_party_scored_story_count

  def initialize(party)
    @party = party
  end

  def perform(params)
    @params = permit_params(params[:verdict_score] || params, PERMITS)
    run_callbacks :perform do
      return add_error(:verdict_score_found) unless @verdict_score.save
      @verdict_score
    end
  end

  private

  def can_not_score
    # TODO : Block user
  end

  def check_story
    context = Party::VerdictScoreCheckInfoContext.new(@party)
    @story = context.perform(@params)
    return add_error(:data_blank, context.error_messages.join(",")) unless @story
  end

  def check_rating_score
    return add_error(:judge_rating_score_blank) unless @params[:rating_score].present?
  end

  def build_verdict_score
    @verdict_score = @party.verdict_scores.new(@params)
  end

  def assign_attribute
    @verdict_score.assign_attributes(story: @story)
  end

  # TODO : alert need refactory, performance issue

  def get_scorer_ids
    schedule_scorer_ids = Story.includes(:schedule_scores).find(@story.id).schedule_scores.where(schedule_rater_type: "Party").map(&:schedule_rater_id)
    verdict_scorer_ids = Story.includes(:verdict_scores).find(@story.id).verdict_scores.where(verdict_rater_type: "Party").map(&:verdict_rater_id)
    @total_scorer_ids = (schedule_scorer_ids + verdict_scorer_ids).uniq
  end

  def get_scored_story_ids
    schedule_scored_story_ids = ScheduleScore.where(schedule_rater: @party).map(&:story_id)
    verdict_scored_story_ids = VerdictScore.where(verdict_rater: @party).map(&:story_id)
    @total_scored_story_ids = (schedule_scored_story_ids + verdict_scored_story_ids).uniq
  end

  def alert_story_by_party_scored_count
    SlackService.notify_scored_time_alert("案件編號 #{@story.id} 同一案件，參與評鑑的「當事人人數」超過 #{Story::MAX_PARTY_SCORED_COUNT} 人") if @total_scorer_ids.count >= Story::MAX_PARTY_SCORED_COUNT && !@total_scorer_ids.include?(@party.id)
  end

  def alert_party_scored_story_count
    SlackService.notify_scored_time_alert("當事人 #{@party.name} 已評鑑超過超過 #{Party::MAX_SCORED_COUNT}") if @total_scored_story_ids.count >= Party::MAX_SCORED_COUNT && !@total_scored_story_ids.include?(@story.id)
  end
end
