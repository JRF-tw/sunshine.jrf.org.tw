class Admin::ProsecutorsOfficeUpdateContext < BaseContext
  PERMITS = Admin::ProsecutorsOfficeCreateContext:: PERMITS

  before_perform :assign_value

  def initialize(prosecutors_office)
    @prosecutors_office = prosecutors_office
  end

  def perform(params)
    @params = permit_params(params[:admin_prosecutors_office] || params, PERMITS)
    run_callbacks :perform do
      return add_error(:data_update_fail, @prosecutors_office.errors.full_messages) unless @prosecutors_office.save
      true
    end
  end

  private

  def assign_value
    @prosecutors_office.assign_attributes @params
  end
end
