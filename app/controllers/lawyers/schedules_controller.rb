class Lawyers::SchedulesController < Lawyers::BaseController
  before_action :schedule_score, except: [:edit, :update]
  before_action :find_schedule_score, only: [:edit, :update]
  before_action :story_adjudged?, only: [:edit, :update]

  def rule
    set_meta
  end

  def new
    set_meta
  end

  def create
    context = Lawyer::ScheduleScoreCreateContext.new(current_lawyer)
    if @record = context.perform(schedule_score_params)
      render_as_success(:thanks_scored)
    else
      redirect_as_fail(new_lawyer_score_schedule_path(schedule_score: schedule_score_params), context.error_messages.join(','))
    end
  end

  def edit
    set_meta
  end

  def update
    context = Lawyer::ScheduleScoreUpdateContext.new(@schedule_score)
    if @record = context.perform(schedule_score_params)
      render_as_success(:thanks_scored)
    else
      context.errors
      render_as_fail(:edit, context.error_messages.join(','))
    end
  end

  def input_info
    set_meta
  end

  def check_info
    context = Lawyer::CheckScheduleScoreInfoContext.new(current_lawyer)
    if context.perform(schedule_score_params)
      redirect_as_success(input_date_lawyer_score_schedules_path(schedule_score: schedule_score_params))
    else
      redirect_as_fail(input_info_lawyer_score_schedules_path(schedule_score: schedule_score_params), context.error_messages.join(','))
    end
  end

  def input_date
    set_meta
  end

  def check_date
    context = Lawyer::CheckScheduleScoreDateContext.new(current_lawyer)
    context.perform(schedule_score_params)
    if context.has_error?
      redirect_as_fail(input_date_lawyer_score_schedules_path(schedule_score: schedule_score_params), context.error_messages.join(','))
    else
      redirect_as_success(input_judge_lawyer_score_schedules_path(schedule_score: schedule_score_params))
    end
  end

  def input_judge
    set_meta
  end

  def check_judge
    context = Lawyer::CheckScheduleScoreJudgeContext.new(current_lawyer)
    if context.perform(schedule_score_params)
      redirect_as_success(new_lawyer_score_schedule_path(schedule_score: schedule_score_params))
    else
      redirect_as_fail(input_judge_lawyer_score_schedules_path(schedule_score: schedule_score_params), context.error_messages.join(','))
    end
  end

  def thanks_scored
    set_meta
  end

  private

  def schedule_score_params
    params.fetch(:schedule_score, {}).permit(
      [:id, :court_id, :year, :word_type, :number, :story_type,
       :start_on, :confirmed_realdate, :judge_name, :note, :appeal_judge] +
      ScheduleScore.stored_attributes[:attitude_scores] +
      ScheduleScore.stored_attributes[:command_scores]
    )
  end

  def schedule_score
    @schedule_score = ScheduleScore.new(schedule_score_params)
  end

  def find_schedule_score
    @schedule_score = current_lawyer.schedule_scores.find(params[:id])
    redirect_as_fail(lawyer_root_path, '沒有該評鑑紀錄') unless @schedule_score
  end

  def story_adjudged?
    redirect_as_fail(lawyer_root_path, '案件已判決') if @schedule_score.story.adjudge_date.present?
  end
end
