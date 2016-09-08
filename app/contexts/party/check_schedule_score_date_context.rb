class Party::CheckScheduleScoreDateContext < BaseContext
  PERMITS = [:court_id, :year, :word_type, :number, :date, :confirmed_realdate].freeze
  SCORE_INTERVEL = 14.days
  MAX_REPORT_TIME = 5

  before_perform :check_date
  before_perform :future_date
  before_perform :find_story, unless: :report_realdate?
  before_perform :find_schedule, unless: :report_realdate?
  before_perform :valid_score_intervel
  after_perform :record_report_time, if: :report_realdate?
  after_perform :alert!, if: :report_realdate?

  def initialize(party)
    @party = party
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
    return add_error(:open_court_date_blank) unless @params[:date].present?
  end

  def future_date
    return add_error(:invalid_date) if @params[:date].to_date > Time.zone.today
  end

  def find_story
    stroy_params = @params.except(:date, :confirmed_realdate)
    return add_error(:story_not_exist) unless @story = Story.where(stroy_params).last
  end

  def find_schedule
    return add_error(:wrong_schedule) unless @schedule = @story.schedules.on_day(@params[:date]).last
  end

  def valid_score_intervel
    range = (@params[:date].to_date..@params[:date].to_date + SCORE_INTERVEL)
    return add_error(:out_score_intervel) unless range.include?(Time.zone.today)
  end

  def record_report_time
    @party.score_report_schedule_real_date.increment
  end

  def alert!
    if @party.score_report_schedule_real_date.value >= MAX_REPORT_TIME
      SlackService.user_report_schedule_date_over_range_async("當事人 : #{@party.name} 已超過回報庭期真實開庭日期次數")
    end
  end
end
