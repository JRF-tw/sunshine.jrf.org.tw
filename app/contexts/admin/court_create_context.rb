class Admin::CourtCreateContext < BaseContext
  PERMITS = [:court_type, :full_name, :name, :weight, :is_hidden].freeze

  before_perform :build_court
  after_perform :update_weight
  after_perform :add_weight
  attr_reader :court

  def initialize(params)
    @params = permit_params(params[:admin_court] || params, PERMITS)
  end

  def perform
    run_callbacks :perform do
      if @court.save
        @court
      else
        add_error(:data_create_fail, @court.errors.full_messages)
      end
    end
  end

  private

  def build_court
    @court = Admin::Court.new(@params)
  end

  def update_weight
    if @params[:weight] && @params[:weight].to_i.to_s == @params[:weight]
      @court.update_attributes(weight: @params[:weight].to_i)
    end
  end

  def add_weight
    if is_court? && !@court.is_hidden && @court.not_in_list?
      @court.insert_at(1)
      @court.move_to_bottom
    end
  end

  def is_court?
    @court.court_type == "法院"
  end

end
