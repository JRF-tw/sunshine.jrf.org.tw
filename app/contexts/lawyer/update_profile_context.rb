class Lawyer::UpdateProfileContext < BaseContext
  PERMITS = [:name, :phone_number, :office_number, :active_notice].freeze

  before_perform :parse_number
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

  def parse_number
    @params = @params.except!(:phone_number) unless @params[:phone_number].present?
    @params = @params.except!(:office_number) unless @params[:office_number].present?
  end

  def assign_value
    @lawyer.assign_attributes(@params)
  end
end
