class Bystander::UpdateProfileContext < BaseContext
  PERMITS = [:name, :phone_number, :school, :department_level, :student_number].freeze

  before_perform :parse_phone_number
  before_perform :assign_value

  def initialize(bystander)
    @bystander = bystander
  end

  def perform(params)
    @params = permit_params(params[:bystander] || params, PERMITS)
    run_callbacks :perform do
      return add_error(:data_update_fail, @bystander.errors.full_messages.join("\n")) unless @bystander.save
      true
    end
  end

  private

  def parse_phone_number
    @params = @params.except!(:phone_number) unless @params[:phone_number].present?
  end

  def assign_value
    @bystander.assign_attributes(@params)
  end
end

