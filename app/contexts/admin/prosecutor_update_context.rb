class Admin::ProsecutorUpdateContext < BaseContext
  PERMITS = Admin::ProsecutorCreateContext:: PERMITS

  before_perform :assign_value

  def initialize(prosecutor)
    @prosecutor = prosecutor
  end

  def perform(params)
    @params = permit_params(params[:admin_prosecutor] || params, PERMITS)
    run_callbacks :perform do
      return add_error(:data_update_fail, @prosecutor.errors.full_messages) unless @prosecutor.save
      true
    end
  end

  private

  def assign_value
    @prosecutor.assign_attributes @params
  end
end
