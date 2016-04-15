class JudgeUpdateContext < BaseContext
  PERMITS = [:name, :current_court_id, :avatar, :court, :remove_avatar, :gender, :birth_year, :stage, :appointment, :memo, :gender_source, :birth_year_source, :stage_source, :appointment_source, :is_active, :is_hidden].freeze

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