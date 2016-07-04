class Admin::JudgeCreateContext < BaseContext
  PERMITS = [:name, :current_court_id, :avatar, :court, :remove_avatar, :gender, :birth_year, :stage, :appointment, :memo, :gender_source, :birth_year_source, :stage_source, :appointment_source, :is_active, :is_hidden].freeze

  before_perform :build_judge

  def initialize(params)
    @params = permit_params(params[:admin_judge] || params, PERMITS)
  end

  def perform
    run_callbacks :perform do
      if @judge.save
        @judge
      else
        add_error(:data_create_fail, @judge.errors.full_messages.join("\n"))
      end
    end
  end

  private

  def build_judge
    @judge = Admin::Judge.new(@params)
  end

end
