class Lawyer::ConfirmContext < BaseContext
  PERMITS = [:confirmation_token, :password, :password_confirmation].freeze

  before_perform :find_lawyer_by_token
  before_perform :check_and_assign_password

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

  def find_lawyer_by_token
    @lawyer = Lawyer.find_by_confirmation_token @params[:confirmation_token]

    return add_error(:lawyer_not_found, "無此律師資料") unless @lawyer
    @lawyer
  end

  def check_and_assign_password
    return add_error(:data_update_fail, "密碼與密碼確認不相符") unless @params[:password] == @params[:password_confirmation]
    return add_error(:data_update_fail, "密碼長度不符(最少八個字元") unless @params[:password].size >= 8
    @lawyer.assign_attributes @params
  end

end
