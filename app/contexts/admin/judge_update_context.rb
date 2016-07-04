class Admin::JudgeUpdateContext < BaseContext
  PERMITS = Admin::JudgeCreateContext:: PERMITS

  before_perform :assign_value

  def initialize(judge)
    @judge = judge
  end

  def perform(params)
    @params = permit_params(params[:admin_judge] || params, PERMITS)
    run_callbacks :perform do
      return add_error(:data_update_fail, @judge.errors.full_messages.join("\n")) unless @judge.save
      true
    end
  end

  private

  def assign_value
    @judge.assign_attributes @params
  end
end
