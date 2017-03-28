class CourtObservers::SchedulesController < CourtObservers::BaseController
  before_action :schedule_score, except: [:edit, :update, :destroy]
  before_action :find_schedule_score, only: [:edit, :update, :destroy]
  before_action :story_adjudged?, only: [:edit, :update, :destroy]
  before_action :init_meta, only: [:rule, :new, :edit, :input_info, :input_date, :input_judge, :thanks_scored]

  def rule
  end

  def new
  end

  def create
    context = CourtObserver::ScheduleScoreCreateContext.new(current_court_observer)
    if @record = context.perform(schedule_score_params)
      render_as_success(:thanks_scored)
    else
      redirect_as_fail(new_court_observer_score_schedule_path(schedule_score: schedule_score_params), context.error_messages.join(','))
    end
  end

  def edit
  end

  def update
    context = CourtObserver::ScheduleScoreUpdateContext.new(@schedule_score)
    if @record = context.perform(schedule_score_params)
      render_as_success(:thanks_scored)
    else
      context.errors
      render_as_fail(:edit, context.error_messages.join(','))
    end
  end

  def destroy
    story = @schedule_score.story
    context = CourtObserver::ScheduleScoreDeleteContext.new(@schedule_score)
    if context.perform
      flash[:success] = '開庭評鑑已刪除'
    else
      flash[:error] = context.error_messages.join(',')
    end
    return redirect_to court_observer_root_path unless current_court_observer.schedule_scores.where(story: story).count > 0
    redirect_to court_observer_story_path(story)
  end

  def input_info
  end

  def check_info
    context = CourtObserver::CheckScheduleScoreInfoContext.new(current_court_observer)
    if context.perform(schedule_score_params)
      redirect_as_success(input_date_court_observer_score_schedules_path(schedule_score: schedule_score_params))
    else
      redirect_as_fail(input_info_court_observer_score_schedules_path(schedule_score: schedule_score_params), context.error_messages.join(','))
    end
  end

  def input_date
  end

  def check_date
    context = CourtObserver::CheckScheduleScoreDateContext.new(current_court_observer)
    context.perform(schedule_score_params)
    if context.has_error?
      redirect_as_fail(input_date_court_observer_score_schedules_path(schedule_score: schedule_score_params), context.error_messages.join(','))
    else
      redirect_as_success(input_judge_court_observer_score_schedules_path(schedule_score: schedule_score_params))
    end
  end

  def input_judge
  end

  def check_judge
    context = CourtObserver::CheckScheduleScoreJudgeContext.new(current_court_observer)
    if context.perform(schedule_score_params)
      redirect_as_success(new_court_observer_score_schedule_path(schedule_score: schedule_score_params))
    else
      redirect_as_fail(input_judge_court_observer_score_schedules_path(schedule_score: schedule_score_params), context.error_messages.join(','))
    end
  end

  def thanks_scored
  end

  private

  def schedule_score_params
    params.fetch(:schedule_score, {}).permit(
      [:id, :court_id, :year, :word_type, :number, :story_type, :start_on,
       :confirmed_realdate, :judge_name, :rating_score, :note, :appeal_judge] +
      ScheduleScore.stored_attributes[:attitude_scores]
    )
  end

  def schedule_score
    @schedule_score = ScheduleScore.new(schedule_score_params)
  end

  def find_schedule_score
    @schedule_score = current_court_observer.schedule_scores.find(params[:id])
    redirect_as_fail(court_observer_root_path, '沒有該評鑑紀錄') unless @schedule_score
  end

  def story_adjudged?
    redirect_as_fail(court_observer_root_path, '案件已判決') if @schedule_score.story.adjudge_date.present?
  end

  def init_meta
    set_meta
  end
end
