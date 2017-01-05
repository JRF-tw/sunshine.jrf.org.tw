class Scrap::ImportCourtContext < BaseContext
  before_perform  :check_data
  before_perform  :tricky_court_data
  before_perform  :find_court
  before_perform  :build_court
  before_perform  :update_name, unless: :is_new_record?
  before_perform  :update_fullname, unless: :is_new_record?
  before_perform  :update_scrap_name, unless: :is_new_record?
  before_perform  :update_code, unless: :is_new_record?
  after_perform   :notify_diff_fullname
  after_perform   :record_count_to_daily_notify

  class << self
    def perform(data_hash)
      new(data_hash).perform
    end
  end

  def initialize(data_hash)
    @data_hash = data_hash
    @scrap_name = data_hash[:scrap_name]
    @code = data_hash[:code]
  end

  def perform
    run_callbacks :perform do
      return add_error(:scrap_court_create_fail) unless @court.save
      @court
    end
  end

  def check_data
    return add_error(:scrap_data_info_incorrect) unless @scrap_name && @code
  end

  def tricky_court_data
    return add_error(:scrap_tricky_court_data) if @scrap_name == '臺灣高等法院－訴願決定' && @code == 'TPH'
  end

  def find_court
    @court = Court.find_by(code: @code) || Court.find_by(scrap_name: @scrap_name) || Court.find_by(full_name: @scrap_name.delete(' '))
  end

  def build_court
    @court = Court.new(name: @scrap_name, full_name: @scrap_name, scrap_name: @scrap_name, code: @code) unless @court
  end

  def is_new_record?
    @court.new_record?
  end

  def update_name
    @court.assign_attributes(name: @scrap_name) unless @court.name
  end

  def update_fullname
    @court.assign_attributes(full_name: @scrap_name) unless @court.full_name
  end

  def update_scrap_name
    @court.assign_attributes(scrap_name: @scrap_name)
  end

  def update_code
    @court.assign_attributes(code: @code)
  end

  def notify_diff_fullname
    SlackService.notify_court_alert("法院全名與爬蟲不符合 :\n爬蟲名稱 : #{@scrap_name}\n資料庫名稱 : #{@court.full_name}") if @court.full_name != @scrap_name
  end

  def record_count_to_daily_notify
    Redis::Counter.new('daily_scrap_court_count').increment
  end
end
