class CourtUpdateContext < BaseContext
  PERMITS = [:court_type, :full_name, :name, :weight, :is_hidden].freeze

  before_perform :assign_value

  def initialize(court)
    @court = court
  end

  def perform(params)
    @params = permit_params(params[:admin_court] || params, PERMITS)
    run_callbacks :perform do
      return add_error(:data_update_fail, @court.errors.full_messages.join("\n")) unless @court.save
      true
    end	
  end

  private

  def assign_value
    @court.assign_attributes @params
  end
end	