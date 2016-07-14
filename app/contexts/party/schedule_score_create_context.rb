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
  after_perform  :record_story_schedule_scored_count
  after_perform  :record_party_schedule_scored_count

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
    return add_error(:date_blank, "開庭態度分數為必填") unless @params[:rating_score].present?
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
    @schedule_score.assign_attributes(schedule: @schedule, judge: @judge)
  end

  def record_story_schedule_scored_count
    SlackService.notify_scored_time_alert("案件編號 #{@story.id} 已超過被評鑑最大值") if @story.schedule_scored_count.increment >= STORY_SCORED_COUNT
  end

  def record_party_schedule_scored_count
    SlackService.notify_scored_time_alert("當事人 #{@party.name} 已超過評鑑案件最大值") if @party.schedule_scored_count.increment >= PARTY_SCORED_COUNT
  end
end
