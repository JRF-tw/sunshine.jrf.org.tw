class CourtObservers::SchedulesController < CourtObservers::BaseController
  before_action :schedule_score, except: [:edit, :update]
  before_action :find_schedule_score, only: [:edit, :update]
  before_action :story_adjudged?, only: [:edit, :update]

  def rule
    # meta
    set_meta(
      title: '觀察者評鑑開庭規則頁',
      description: '觀察者評鑑開庭規則頁',
      keywords: '觀察者評鑑開庭規則頁'
    )
  end

  def new
    # meta
    set_meta(
      title: '觀察者建立評鑑頁',
      description: '觀察者建立評鑑頁',
      keywords: '觀察者建立評鑑頁'
    )
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
    # meta
    set_meta(
      title: '觀察者編輯評鑑頁',
      description: '觀察者編輯評鑑頁',
      keywords: '觀察者編輯評鑑頁'
    )
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

  def input_info
    # meta
    set_meta(
      title: '觀察者輸入案件資訊頁',
      description: '觀察者輸入案件資訊頁',
      keywords: '觀察者輸入案件資訊頁'
    )
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
    # meta
    set_meta(
      title: '觀察者輸入庭期日期頁',
      description: '觀察者輸入庭期日期頁',
      keywords: '觀察者輸入庭期日期頁'
    )
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
    # meta
    set_meta(
      title: '觀察者輸入法官頁',
      description: '觀察者輸入法官頁',
      keywords: '觀察者輸入法官頁'
    )
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
    # meta
    set_meta(
      title: '觀察者評鑑感謝頁',
      description: '觀察者評鑑感謝頁',
      keywords: '觀察者評鑑感謝頁'
    )
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
end
