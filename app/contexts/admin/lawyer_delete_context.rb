class Admin::LawyerDeleteContext < BaseContext
  before_perform :check_verdict_empty
  before_perform :check_confirm
  before_perform :check_password

  def initialize(lawyer)
    @lawyer = lawyer
  end

  def perform
    run_callbacks :perform do
      @lawyer.destroy
    end
  end

  def check_verdict_empty
    return add_error(:lawyer_have_judgement) if @lawyer.verdict_relations.present?
  end

  def check_confirm
    return add_error(:lawyer_already_register) if @lawyer.confirmed?
  end

  def check_password
    return add_error(:lawyer_have_password) if @lawyer.encrypted_password.present?
  end
end
