class Admin::CourtUpdateContext < BaseContext
  PERMITS = [:court_type, :full_name, :name, :weight, :is_hidden].freeze

  before_perform :assign_weight
  before_perform :assign_value
  after_perform :remove_weight
  after_perform :add_weight

  def initialize(court)
    @court = court
  end

  def perform(params)
    @params = permit_params(params[:admin_court] || params, PERMITS)
    run_callbacks :perform do
      return add_error(:data_update_fail, @court.errors.full_messages) unless @court.save
      true
    end
  end

  private

  def assign_weight
    if @params[:weight].to_i.to_s == @params[:weight]
      @params[:weight] = @params[:weight].to_i
    elsif @params[:weight]
      @params.delete :weight
    end
    true
  end

  def assign_value
    @court.assign_attributes @params
  end

  def remove_weight
    if (!is_court? || @court.is_hidden) && @court.in_list?
      @court.remove_from_list
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
