class LawyerDeleteContext < BaseContext
  before_perform :check_verdict_empty
  before_perform :check_not_confirm

  def initialize(lawyer)
    @lawyer = lawyer
  end

  def perform
    run_callbacks :perform do
      @lawyer.destroy
    end
  end

  def check_verdict_empty
    return add_error(:data_delete_fail, "該律師已有判決書") if @lawyer.verdicts.present?
    true
  end

  def check_not_confirm
    return add_error(:data_delete_fail, "該律師已經註冊") if @lawyer.confirmed?
    true
  end
end
