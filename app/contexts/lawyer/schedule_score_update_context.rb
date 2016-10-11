class Lawyer::ScheduleScoreUpdateContext < BaseContext
  PERMITS = [:command_score, :attitude_score, :note, :appeal_judge].freeze

  before_perform :check_command_score
  before_perform :check_attitude_score
  before_perform :assign_attribute

  def initialize(schedule_score)
    @schedule_score = schedule_score
  end

  def perform(params)
    @params = permit_params(params[:schedule_score] || params, PERMITS)
    run_callbacks :perform do
      return add_error(:schedule_score_update_fail) unless @schedule_score.save
      @schedule_score
    end
  end

  private

  def check_command_score
    return add_error(:command_score_blank) unless @params[:command_score].present?
  end

  def check_attitude_score
    # TODO : check score type attitude_score & rating_score
    return add_error(:schedule_attitude_score_blank) unless @params[:attitude_score].present?
  end

  def assign_attribute
    @schedule_score.assign_attributes(@params)
  end
end
