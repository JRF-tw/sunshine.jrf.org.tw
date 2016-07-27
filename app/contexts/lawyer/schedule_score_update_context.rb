class Lawyer::ScheduleScoreUpdateContext < BaseContext
  PERMITS = [:command_score, :attitude_score, :note, :appeal_judge].freeze

  before_perform :check_command_score
  before_perform :check_attitude_score
  before_perform :assign_attribute

  def initialize(lawyer, schedule_score)
    @lawyer = lawyer
    @schedule_score = schedule_score
  end

  def perform(params)
    @params = permit_params(params[:schedule_score] || params, PERMITS)
    run_callbacks :perform do
      return add_error(:data_update_fail, "評鑑更新失敗") unless @schedule_score.save
      @schedule_score
    end
  end

  private

  def check_command_score
    return add_error(:data_blank, "訴訟指揮分數為必填") unless @params[:command_score].present?
  end

  def check_attitude_score
    # TODO : check score type attitude_score & rating_score
    return add_error(:data_blank, "開庭滿意度分數為必填") unless @params[:attitude_score].present?
  end

  def assign_attribute
    @schedule_score.assign_attributes(@params)
  end
end
