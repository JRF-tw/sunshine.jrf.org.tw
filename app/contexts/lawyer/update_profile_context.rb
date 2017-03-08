class Lawyer::UpdateProfileContext < BaseContext
  PERMITS = [:name, :phone_number, :office_number, :active_notice].freeze

  before_perform :assign_value

  def initialize(lawyer)
    @lawyer = lawyer
  end

  def perform(params)
    @params = permit_params(params[:lawyer] || params, PERMITS)
    run_callbacks :perform do
      return add_error(:data_update_fail, @lawyer.errors.full_messages.join("\n")) unless @lawyer.save
      true
    end
  end

  private

  def assign_value
    @lawyer.assign_attributes(@params)
  end
end
