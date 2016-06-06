class Lawyer::SendSetPasswordEmailContext < BaseContext

  before_perform :check_lawyer_not_confirm


  def initialize(lawyer)
    @lawyer = lawyer
  end

  def perform
    run_callbacks :perform do
      @lawyer.send_confirmation_instructions
      true
    end
  end

  private

  def check_lawyer_not_confirm
    return add_error(:send_email_fail, "該律師已驗證") if @lawyer.confirmed?
  end

end
