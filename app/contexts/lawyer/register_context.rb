class Lawyer::RegisterContext < BaseContext
  PERMITS = [:name, :email].freeze

  before_perform :check_lawyer_params
  before_perform :find_lawyer_by_params
  before_perform :check_lawyer_not_active

  def initialize(params)
    @params = permit_params(params[:lawyer] || params, PERMITS)
  end

  def perform
    run_callbacks :perform do
      return add_error(:send_email_fail, "認證信寄送失敗") unless @lawyer.send_confirmation_instructions
      @lawyer
    end
  end

  private

  def check_lawyer_params
    add_error(:date_blank, "姓名不可為空白字元") if @params[:name].blank?
    add_error(:date_blank, "email不可為空白字元") if @params[:email].blank?

    return if @params[:name].blank? || @params[:email].blank?
  end

  def find_lawyer_by_params
    @lawyer = Lawyer.find_by(name: @params[:name], email: @params[:email])
    return add_error(:lawyer_not_found, "查無此律師資料 請改以人工管道註冊") unless @lawyer
  end

  def check_lawyer_not_active
    return add_error(:lawyer_exist, "已經註冊 請直接登入") if @lawyer.confirmed?
  end

end
