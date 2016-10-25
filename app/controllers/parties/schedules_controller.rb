class Parties::SchedulesController < Parties::BaseController
  layout 'party'
  include CrudConcern
  before_action :schedule_score, except: [:edit, :update]
  before_action :find_schedule_score, only: [:edit, :update]
  before_action :story_adjudged?, only: [:edit, :update]

  def rule
    # meta
    set_meta(
      title: '當事人開庭評鑑規則頁',
      description: '當事人開庭評鑑規則頁',
      keywords: '當事人開庭評鑑規則頁'
    )
  end

  def new
    # meta
    set_meta(
      title: '當事人開庭評鑑輸入頁',
      description: '當事人開庭評鑑輸入頁',
      keywords: '當事人開庭評鑑輸入頁'
    )
  end

  def create
    context = Party::ScheduleScoreCreateContext.new(current_party)
    if @record = context.perform(schedule_score_params)
      render_as_success(:thanks_scored)
    else
      redirect_as_fail(new_party_score_schedule_path(schedule_score: schedule_score_params), context.error_messages.join(','))
    end
  end

  def edit
    # meta
    set_meta(
      title: '當事人開庭評鑑編輯頁',
      description: '當事人開庭評鑑編輯頁',
      keywords: '當事人開庭評鑑編輯頁'
    )
  end

  def update
    context = Party::ScheduleScoreUpdateContext.new(@schedule_score)
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
      title: '當事人開庭評鑑案件輸入頁',
      description: '當事人開庭評鑑案件輸入頁',
      keywords: '當事人開庭評鑑案件輸入頁'
    )
  end

  def check_info
    context = Party::CheckScheduleScoreInfoContext.new(current_party)
    if context.perform(schedule_score_params)
      redirect_as_success(input_date_party_score_schedules_path(schedule_score: schedule_score_params))
    else
      redirect_as_fail(input_info_party_score_schedules_path(schedule_score: schedule_score_params), context.error_messages.join(','))
    end
  end

  def input_date
    # meta
    set_meta(
      title: '當事人開庭評鑑庭期輸入頁',
      description: '當事人開庭評鑑庭期輸入頁',
      keywords: '當事人開庭評鑑庭期輸入頁'
    )
  end

  def check_date
    context = Party::CheckScheduleScoreDateContext.new(current_party)
    context.perform(schedule_score_params)
    if context.has_error?
      redirect_as_fail(input_date_party_score_schedules_path(schedule_score: schedule_score_params), context.error_messages.join(','))
    else
      redirect_as_success(input_judge_party_score_schedules_path(schedule_score: schedule_score_params))
    end
  end

  def input_judge
    # meta
    set_meta(
      title: '當事人開庭評鑑法官輸入頁',
      description: '當事人開庭評鑑法官輸入頁',
      keywords: '當事人開庭評鑑法官輸入頁'
    )
  end

  def check_judge
    context = Party::CheckScheduleScoreJudgeContext.new(current_party)
    if context.perform(schedule_score_params)
      redirect_as_success(new_party_score_schedule_path(schedule_score: schedule_score_params))
    else
      redirect_as_fail(input_judge_party_score_schedules_path(schedule_score: schedule_score_params), context.error_messages.join(','))
    end
  end

  def thanks_scored
    # meta
    set_meta(
      title: '當事人開庭評鑑感謝頁',
      description: '當事人開庭評鑑感謝頁',
      keywords: '當事人開庭評鑑感謝頁'
    )
  end

  private

  def schedule_score_params
    params.fetch(:schedule_score, {}).permit(:id, :court_id, :year, :word_type, :number, :story_type, :start_on, :confirmed_realdate, :judge_name, :rating_score, :note, :appeal_judge)
  end

  def schedule_score
    @schedule_score = ScheduleScore.new(schedule_score_params)
  end

  def find_schedule_score
    @schedule_score = current_party.schedule_scores.find(params[:id])
    redirect_as_fail(party_root_path, '沒有該評鑑紀錄') unless @schedule_score
  end

  def story_adjudged?
    redirect_as_fail(party_root_path, '案件已判決') if @schedule_score.story.adjudge_date.present?
  end
end
