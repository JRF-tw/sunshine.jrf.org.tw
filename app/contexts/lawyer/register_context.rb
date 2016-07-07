class Lawyer::RegisterContext < BaseContext
  PERMITS = [:name, :email].freeze

  before_perform :check_lawyer_params
  before_perform :find_lawyer_by_params
  before_perform :check_lawyer_not_active
  before_perform :check_agree_policy
  after_perform :generate_token
  after_perform :send_confirm_mail

  def initialize(params)
    @params = permit_params(params[:lawyer] || params, PERMITS)
    @params[:policy_agreement] = true if params[:policy_agreement]
  end

  def perform
    run_callbacks :perform do
      @lawyer
    end
  end

  private

  def check_agree_policy
    return add_error(:without_policy_agreement, "您尚未勾選同意條款") unless @params[:policy_agreement]
  end

  def check_lawyer_params
    add_error(:date_blank, "姓名不可為空白字元") if @params[:name].blank?
    add_error(:date_blank, "email不可為空白字元") if @params[:email].blank?

    return false if errors.present?
  end

  def find_lawyer_by_params
    @lawyer = Lawyer.find_by(name: @params[:name], email: @params[:email])
    return add_error(:lawyer_not_found, %(查無此律師資料 請改以人工管道註冊 <a href="/lawyer/appeal/new">點此註冊</a>)) unless @lawyer
  end

  def check_lawyer_not_active
    return add_error(:lawyer_exist, "已經註冊 請直接登入") if @lawyer.confirmed?
  end

  def generate_token
    @token = @lawyer.set_confirmation_token
  end

  def send_confirm_mail
    CustomDeviseMailer.delay.send_confirm_mail(@lawyer, @token)
  end

end
