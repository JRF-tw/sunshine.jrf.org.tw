class Lawyers::SchedulesController < Lawyers::BaseController
  layout "lawyer"
  include CrudConcern
  before_action :schedule_score

  def new
  end

  def rule
  end

  def checked_info
    context = Lawyer::CheckScheduleScoreInfoContext.new(current_lawyer)
    if context.perform(schedule_score_params)
      @status = "checked_info"
      render_as_success(:new)
    else
      render_as_fail(:new, context.error_messages.join(","))
    end
  end

  def checked_date
    context = Lawyer::CheckScheduleScoreDateContext.new(current_lawyer)
    context.perform(schedule_score_params)
    if context.has_error?
      @status = "checked_info"
      render_as_fail(:new, context.error_messages.join(","))
    else
      @status = "checked_date"
      render_as_success(:new)
    end
  end

  def checked_judge
    context = Lawyer::CheckScheduleScoreJudgeContext.new(current_lawyer)
    if context.perform(schedule_score_params)
      @status = "checked_judge"
      render_as_success(:new)
    else
      @status = "checked_date"
      render_as_fail(:new, context.error_messages.join(","))
    end
  end

  def create
    context = Lawyer::ScheduleScoreCreateContext.new(current_lawyer)
    if context.perform(schedule_score_params)
      redirect_as_success(lawyer_scores_path, "評鑑已成功建立")
    else
      @status = "checked_judge"
      render_as_fail(:new, context.error_messages.join(","))
    end
  end

  private

  def schedule_score_params
    params.fetch(:schedule_score, {}).permit(:court_id, :year, :word_type, :number, :date, :confirmed_realdate, :judge_name, :command_score, :attitude_score, :note, :appeal_judge)
  end

  def schedule_score
    @schedule_score = ScheduleScore.new(schedule_score_params)
  end
end
