class Parties::VerdictsController < Parties::BaseController
  layout "party"
  include CrudConcern
  before_action :verdict_score, except: [:edit, :update]
  before_action :find_verdict_score, only: [:edit, :update]
  before_action :story_can_score?, only: [:edit, :update]

  def rule
    # meta
    set_meta(
      title: "當事人判決評鑑規則頁",
      description: "當事人判決評鑑規則頁",
      keywords: "當事人判決評鑑規則頁"
    )
  end

  def thanks_scored
    # meta
    set_meta(
      title: "當事人判決評鑑感謝頁",
      description: "當事人判決評鑑感謝頁",
      keywords: "當事人判決評鑑感謝頁"
    )
  end

  def new
    # meta
    set_meta(
      title: "當事人新增判決評鑑頁",
      description: "當事人新增判決評鑑頁",
      keywords: "當事人新增判決評鑑頁"
    )
  end

  def edit
    # meta
    set_meta(
      title: "當事人判決評鑑編輯頁",
      description: "當事人判決評鑑編輯頁",
      keywords: "當事人判決評鑑編輯頁"
    )
  end

  def update
    context = Party::VerdictScoreUpdateContext.new(@verdict_score)
    if @record = context.perform(verdict_score_params)
      redirect_as_success(thanks_scored_party_score_verdicts_path, "評鑑已更新")
    else
      render_as_fail(:edit, context.error_messages.join(","))
    end
  end

  def input_info
    # meta
    set_meta(
      title: "當事人判決評鑑案件輸入頁",
      description: "當事人判決評鑑案件輸入頁",
      keywords: "當事人判決評鑑案件輸入頁"
    )
  end

  def check_info
    context = Party::VerdictScoreCheckInfoContext.new(current_party)
    if @story = context.perform(verdict_score_params)
      redirect_as_success(new_party_score_verdict_path(verdict_score: verdict_score_params))
    else
      redirect_as_fail(input_info_party_score_verdicts_path(verdict_score: verdict_score_params), context.error_messages.join(","))
    end
  end

  def create
    context = Party::VerdictScoreCreateContext.new(current_party)
    if context.perform(verdict_score_params)
      redirect_as_success(thanks_scored_party_score_verdicts_path, "評鑑已新增")
    else
      redirect_as_fail(new_party_score_verdict_path(verdict_score: verdict_score_params), context.error_messages.join(","))
    end
  end

  private

  def verdict_score_params
    params.fetch(:verdict_score, {}).permit(:court_id, :year, :word_type, :number, :story_type, :confirmed_realdate, :rating_score, :note, :appeal_judge)
  end

  def verdict_score
    @verdict_score = VerdictScore.new(verdict_score_params)
  end

  def find_verdict_score
    @verdict_score = current_party.verdict_scores.find(params[:id])
    redirect_as_fail(party_root_path, "沒有該評鑑紀錄") unless @verdict_score
  end

  def story_can_score?
    range = (@verdict_score.story.adjudge_date..@verdict_score.story.adjudge_date + Party::VerdictScoreCheckInfoContext::SCORE_INTERVEL)
    redirect_as_fail(party_root_path, "案件已超過可評鑑判決時間") unless range.include?(Time.zone.today)
  end
end
