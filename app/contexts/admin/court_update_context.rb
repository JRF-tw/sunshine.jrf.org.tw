class Admin::CourtUpdateContext < BaseContext
  PERMITS = [:court_type, :full_name, :name, :weight, :is_hidden].freeze

  before_perform :assign_weight
  before_perform :assign_value
  after_perform :remove_weight, unless: :court_sortable?
  after_perform :add_weight, if: :court_sortable?

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
    if @params[:weight] && @params[:weight][/^[1-9][0-9]+$/]
      @params[:weight] = @params[:weight].to_i
    elsif @params[:weight]
      @params.delete :weight
    end
    true
  end

  def assign_value
    @court.assign_attributes @params
    @court.court_type = @params[:court_type] if @params[:court_type]
  end

  def remove_weight
    @court.remove_from_list if @court.in_list?
  end

  def add_weight
    if @court.not_in_list?
      @court.insert_at(1)
      @court.move_to_bottom
    end
  end

  def court_sortable?
    is_court? && !@court.is_hidden
  end

  def is_court?
    @court.court_type == "法院"
  end

end
