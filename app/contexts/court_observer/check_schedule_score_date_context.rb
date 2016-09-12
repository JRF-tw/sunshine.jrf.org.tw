class CourtObserver::CheckScheduleScoreDateContext < BaseContext
  PERMITS = [:court_id, :year, :word_type, :number, :start_on, :confirmed_realdate].freeze
  SCORE_INTERVEL = 3.days
  MAX_REPORT_TIME = 5

  before_perform :check_date
  before_perform :future_date
  before_perform :find_story, unless: :report_realdate?
  before_perform :find_schedule, unless: :report_realdate?
  before_perform :valid_score_intervel
  after_perform :record_report_time, if: :report_realdate?
  after_perform :alert!, if: :report_realdate?

  def initialize(court_observer)
    @court_observer = court_observer
  end

  def perform(params)
    @params = permit_params(params[:schedule_score] || params, PERMITS)
    run_callbacks :perform do
      @schedule
    end
  end

  private

  def report_realdate?
    ActiveRecord::Type::Boolean.new.type_cast_from_database(@params[:confirmed_realdate])
  end

  def check_date
    return add_error(:start_on_blank) unless @params[:start_on].present?
  end

  def future_date
    return add_error(:start_on_invalid) if @params[:start_on].to_date > Time.zone.today
  end

  def find_story
    stroy_params = @params.except(:start_on, :confirmed_realdate)
    return add_error(:story_not_found) unless @story = Story.where(stroy_params).last
  end

  def find_schedule
    return add_error(:schedule_not_found) unless @schedule = @story.schedules.on_day(@params[:start_on]).last
  end

  def valid_score_intervel
    range = (@params[:start_on].to_date..@params[:start_on].to_date + SCORE_INTERVEL)
    return add_error(:out_score_intervel) unless range.include?(Time.zone.today)
  end

  def record_report_time
    @court_observer.score_report_schedule_real_date.increment
  end

  def alert!
    if @court_observer.score_report_schedule_real_date.value >= MAX_REPORT_TIME
      SlackService.user_report_schedule_date_over_range_async("旁觀者 : #{@court_observer.name} 已超過回報庭期真實開庭日期次數")
    end
  end
end
