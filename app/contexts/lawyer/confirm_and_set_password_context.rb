class Lawyer::ConfirmAndSetPasswordContext < BaseContext
  PERMITS = [:confirmation_token, :password, :password_confirmation].freeze

  before_perform :find_lawyer
  before_perform :check_lawyer
  before_perform :check_password
  before_perform :assign_password

  def initialize(params)
    @params = permit_params(params[:lawyer] || params, PERMITS)
  end

  def perform
    run_callbacks :perform do
      return add_error(:data_update_fail, "律師認證失敗") unless @lawyer.confirm!
      true
    end
  end

  private

  def find_lawyer
    @lawyer = Lawyer.find_by_confirmation_token @params[:confirmation_token]
  end

  def check_lawyer
    return add_error(:lawyer_not_found, "無此律師資料") unless @lawyer
  end

  def check_password
    add_error(:data_update_fail, "密碼與密碼確認不相符") unless @params[:password] == @params[:password_confirmation]
    add_error(:data_update_fail, "密碼長度不符(最少八個字元") unless @params[:password].size >= 8
    return false unless @params[:password] == @params[:password_confirmation] && @params[:password].size >= 8
  end

  def assign_password
    @lawyer.assign_attributes @params
  end

end
