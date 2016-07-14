class Lawyer::CheckScheduleScoreJudgeContext < BaseContext
  PERMITS = [:court_id, :year, :word_type, :number, :date, :confirmed_realdate, :judge_name].freeze

  before_perform :check_judge_name
  before_perform :find_judge
  before_perform :check_judge_in_correct_court

  def initialize(lawyer)
    @lawyer = lawyer
  end

  def perform(params)
    @params = permit_params(params[:schedule_score] || params, PERMITS)
    run_callbacks :perform do
      @judge
    end
  end

  private

  def check_judge_name
    return add_error(:date_blank, "法官姓名不能為空") unless @params[:judge_name].present?
  end

  def find_judge
    # TODO : need check same name issue
    @judge = Judge.where(name: @params[:judge_name]).last
    return add_error(:data_not_found, "沒有該位法官") unless @judge
  end

  def check_judge_in_correct_court
    return add_error(:data_not_found, "法官不存在該法院") if @judge.current_court_id != @params[:court_id].to_i
  end
end
