class CourtObserver::ScheduleScoreUpdateContext < BaseContext
  PERMITS = [:note, :appeal_judge].freeze + ScheduleScore.stored_attributes[:attitude_scores]

  before_perform :check_attitude_scores
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

  def check_attitude_scores
    ScheduleScore.stored_attributes[:attitude_scores].each do |keys|
      return add_error(:attitude_scores_blank) unless @params[keys].present?
    end
    return false if has_error?
  end

  def assign_attribute
    @schedule_score.assign_attributes(@params)
  end
end
