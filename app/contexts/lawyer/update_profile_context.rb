class Lawyer::UpdateProfileContext < BaseContext
  PERMITS = [:current].freeze

  before_perform :assign_value

  def initialize(lawyer)
    @lawyer = lawyer
  end

  def perform(params)
    @params = permit_params(params[:lawyer] || params, PERMITS)
    run_callbacks :perform do
      return add_error(:data_update_fail, "未能更新個人資訊") unless @lawyer.save
      true
    end
  end

  private

  def assign_value
    @lawyer.assign_attributes(@params)
  end
end

