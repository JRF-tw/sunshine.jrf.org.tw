class Party::CheckScheduleScoreDateContext < BaseContext
  PERMITS = [:court_id, :year, :word_type, :number, :date, :confirmed_realdate].freeze
  SCORE_INTERVEL = 14
  MAX_REPORT_TIME = 5

  before_perform :check_date
  before_perform :future_date
  before_perform :find_story, unless: :report_realdate?
  before_perform :find_schedule, unless: :report_realdate?
  before_perform :valid_score_intervel, unless: :report_realdate?
  after_perform :record_report_time, if: :report_realdate?
  after_perform :alert!, if: :report_realdate?

  def initialize(party)
    @party = party
  end

  def perform(params)
    @params = permit_params(params[:schedule_score] || params, PERMITS)
    run_callbacks :perform do
      @schedule || true
    end
  end

  private

  def report_realdate?
    ActiveRecord::Type::Boolean.new.type_cast_from_database(@params[:confirmed_realdate])
  end

  def check_date
    return add_error(:date_blank, "開庭日期為必填") unless @params[:date].present?
  end

  def future_date
    return add_error(:invalid_date, "開期日期不能為未來時間") if @params[:date].to_date > Time.zone.today
  end

  def find_story
    stroy_params = @params.except(:date, :confirmed_realdate)
    return add_error(:data_not_found, "案件不存在") unless @story = Story.where(stroy_params).last
  end

  def find_schedule
    return add_error(:data_not_found, "庭期比對失敗") unless @schedule = @story.schedules.where(date: @params[:date]).last
  end

  def valid_score_intervel
    range = (@schedule.date..@schedule.date + SCORE_INTERVEL)
    return add_error(:out_score_intervel, "已超過可評鑑時間") unless range.include?(Time.zone.today)
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
