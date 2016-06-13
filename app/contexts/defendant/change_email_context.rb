class Defendant::ChangeEmailContext < BaseContext
  PERMITS = [:unconfirmed_email, :current_password].freeze

  before_perform :check_email_not_empty
  before_perform :check_email_not_use
  before_perform :check_email_different
  after_perform :send_confirmation_email
  def initialize(defendant)
    @defendant = defendant
  end

  def perform(params)
    @params = permit_params(params[:defendant] || params, PERMITS)
    run_callbacks :perform do
      return add_error(:data_update_fail, "email 更新失敗") unless @defendant.update_with_password(@params)
      true
    end
  end

  private

  def check_email_not_empty
    return add_error(:email_conflict, "email 不可為空") if @params["unconfirmed_email"] == ""
  end

  def check_email_not_use
    return add_error(:email_conflict, "email 已經被使用") if Defendant.pluck(:unconfirmed_email).include?(@params["unconfirmed_email"])
  end

  def check_email_different
    return add_error(:email_conflict, "email 不可與原本相同") if @params["unconfirmed_email"] == @defendant.email
  end

  def send_confirmation_email
    @defendant.send_confirmation_instructions
  end

end
