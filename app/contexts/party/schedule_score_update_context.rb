class Party::ScheduleScoreUpdateContext < BaseContext
  PERMITS = [:rating_score, :note, :appeal_judge].freeze

  before_perform :check_rating_score
  before_perform :assign_attribute

  def initialize(schedule_score)
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

  def check_rating_score
    return add_error(:data_blank, "開庭滿意度分數為必填") unless @params[:rating_score].present?
  end

  def assign_attribute
    @schedule_score.assign_attributes(@params)
  end
end