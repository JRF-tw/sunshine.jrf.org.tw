class Admin::CourtWeightUpdateContext < BaseContext
  PERMITS = [:weight].freeze

  def initialize(court)
    @court = court
  end

  def perform(params)
    @params = permit_params(params[:court] || params, PERMITS)
    run_callbacks :perform do
      @court.weight = @params[:weight]
    end
  end

  private

  def check_with_params
    return add_error(:data_update_fail) unless @params[:weight]
  end

end
