class Admin::ProsecutorCreateContext < BaseContext
  PERMITS = [:name, :prosecutors_office_id, :avatar, :judge_id, :judge, :prosecutors_office, :remove_avatar, :gender, :birth_year, :stage, :appointment, :memo, :gender_source, :birth_year_source, :stage_source, :appointment_source, :is_active, :is_hidden].freeze

  before_perform :build_prosecutor
  attr_reader :prosecutor

  def initialize(params)
    @params = permit_params(params[:admin_prosecutor] || params, PERMITS)
  end

  def perform
    run_callbacks :perform do
      return add_error(:data_create_fail, @prosecutor.errors.full_messages) unless @prosecutor.save
      @prosecutor
    end
  end

  private

  def build_prosecutor
    @prosecutor = Admin::Prosecutor.new(@params)
  end

end
