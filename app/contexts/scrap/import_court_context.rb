class Scrap::ImportCourtContext < BaseContext
  SCRAP_URI = "http://jirs.judicial.gov.tw/FJUD/FJUDQRY01_1.aspx"
  before_perform :check_data
  before_perform :find_court
  before_perform :build_court
  before_perform :update_name, unless: :is_new_record?
  before_perform :update_fullname, unless: :is_new_record?
  before_perform :update_scrap_name, unless: :is_new_record?
  before_perform :assign_default_value

  class << self
    def perform(data_hash)
      new(data_hash).perform
    end
  end

  def initialize(data_hash)
    @data_hash = data_hash
    @scrap_name = data_hash[:scrap_name]
    @full_name = @scrap_name.gsub(" ", "")
    @code = data_hash[:code]
  end

  def perform
    run_callbacks :perform do
      return add_error(:data_create_fail, "data not create/update") unless @court.save
      @court
    end
  end

  def check_data
    return add_error(:data_create_fail, "data info incorrect") unless @scrap_name && @code
  end

  def find_court
    @court = Court.find_by(code: @code) || Court.find_by(scrap_name: @scrap_name) || Court.find_by(full_name: @full_name)
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

  def assign_default_value
    @court.assign_attributes(court_type: "法院") unless @court.court_type
    @court.assign_attributes(is_hidden: true) if @court.is_hidden.nil?
  end
end
