class CourtObserver::ScheduleScoreCreateContext < BaseContext
  PERMITS = [ :court_id, :year, :word_type, :number, :story_type, :start_on,
              :confirmed_realdate, :judge_name, :note, :appeal_judge ].freeze +
              ScheduleScore.stored_attributes[:attitude_scores]

  # before_perform :can_not_score
  before_perform :check_story
  before_perform :check_schedule
  before_perform :check_judge
  before_perform :check_attitude_scores
  before_perform :build_schedule_score
  before_perform :assign_attribute

  def initialize(court_observer)
    @court_observer = court_observer
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
    context = CourtObserver::CheckScheduleScoreInfoContext.new(@court_observer)
    @story = context.perform(@params)
    return add_error(:story_not_found, context.error_messages.join(',')) unless @story
  end

  def check_schedule
    context = CourtObserver::CheckScheduleScoreDateContext.new(@court_observer)
    @schedule = context.perform(@params)
    return add_error(:schedule_not_found, context.error_messages.join(',')) if context.has_error?
  end

  def check_judge
    context = CourtObserver::CheckScheduleScoreJudgeContext.new(@court_observer)
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
    @schedule_score = @court_observer.schedule_scores.new(@params)
  end

  def assign_attribute
    @schedule_score.assign_attributes(schedule: @schedule, judge: @judge, story: @story)
  end
end
