class LawyerDeleteContext < BaseContext
  before_perform :check_verdict_empty

  def initialize(lawyer)
    @lawyer = lawyer
  end

  def perform
    run_callbacks :perform do
      @lawyer.destroy
    end
  end

  def check_verdict_empty
    return add_error(:data_delete_fail) if @lawyer.verdicts.present?
    true
  end
end
