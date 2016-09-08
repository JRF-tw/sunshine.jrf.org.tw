class CourtObserver::ScheduleScoreCreateContext < BaseContext
  PERMITS = [:court_id, :year, :word_type, :number, :date, :confirmed_realdate, :judge_name, :rating_score, :note, :appeal_judge].freeze

  # before_perform :can_not_score
  before_perform :check_rating_score
  before_perform :check_story
  before_perform :check_schedule
  before_perform :check_judge
  before_perform :build_schedule_score
  before_perform :assign_attribute

  def initialize(court_observer)
    @court_observer = court_observer
  end

  def perform(params)
    @params = permit_params(params[:schedule_score] || params, PERMITS)
    run_callbacks :perform do
      return add_error(:court_already_judged) unless @schedule_score.save
      @schedule_score
    end
  end

  private

  def can_not_score
    # TODO : Block user
  end

  def check_rating_score
    return add_error(:court_rating_score_blank) unless @params[:rating_score].present?
  end

  def check_story
    context = CourtObserver::CheckScheduleScoreInfoContext.new(@court_observer)
    @story = context.perform(@params)
    return add_error(:data_blank, context.error_messages.join(",")) unless @story
  end

  def check_schedule
    @schedule = CourtObserver::CheckScheduleScoreDateContext.new(@court_observer).perform(@params)
  end

  def check_judge
    @judge = CourtObserver::CheckScheduleScoreJudgeContext.new(@court_observer).perform(@params)
  end

  def build_schedule_score
    @schedule_score = @court_observer.schedule_scores.new(@params)
  end

  def assign_attribute
    @schedule_score.assign_attributes(schedule: @schedule, judge: @judge, story: @story)
  end
end
