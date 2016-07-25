class Lawyer::SendSetPasswordEmailContext < BaseContext

  def initialize(lawyer)
    @lawyer = lawyer
  end

  def perform
    run_callbacks :perform do
      @lawyer.send_reset_password_instructions
    end
  end

end
