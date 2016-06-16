class Bystander::SendSetPasswordEmailContext < BaseContext

  def initialize(bystander)
    @bystander = bystander
  end

  def perform
    run_callbacks :perform do
      @bystander.send_reset_password_instructions
    end
  end

end
