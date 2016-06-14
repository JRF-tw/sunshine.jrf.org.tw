class Bystander::ChangeEmailContext < BaseContext
  PERMITS = [:email, :current_password].freeze

  before_perform :check_email_not_use
  before_perform :check_email_different

  def initialize(bystander)
    @bystander = bystander
  end

  def perform(params)
    @params = permit_params(params[:bystander] || params, PERMITS)
    run_callbacks :perform do
      return add_error(:data_update_fail, "email 更新失敗") unless @bystander.update_with_password(@params)
      true
    end
  end

  private

  def check_email_not_use
    return add_error(:email_conflict, "email 已經被使用") if Bystander.pluck(:unconfirmed_email).include?(@params["email"])
  end

  def check_email_different
    return add_error(:email_conflict, "email 不可與原本相同") if @params["email"] == @bystander.email
  end

end
