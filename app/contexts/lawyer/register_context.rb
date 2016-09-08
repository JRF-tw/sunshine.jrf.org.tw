class Lawyer::RegisterContext < BaseContext
  PERMITS = [:name, :email].freeze

  before_perform :check_lawyer_params
  before_perform :check_email_valid
  before_perform :find_lawyer_by_params
  before_perform :check_lawyer_not_active
  before_perform :check_agree_policy
  after_perform :generate_reset_password_token
  after_perform :send_setting_password_mail

  def initialize(params)
    @params = permit_params(params[:lawyer] || params, PERMITS)
    @params[:policy_agreement] = true if params[:policy_agreement] == "1"
  end

  def perform
    run_callbacks :perform do
      @lawyer
    end
  end

  private

  def check_agree_policy
    return add_error(:without_policy_agreement) unless @params[:policy_agreement]
  end

  def check_lawyer_params
    add_error(:name_blank) if @params[:name].blank?
    add_error(:email_blank) if @params[:email].blank?

    return false if errors.present?
  end

  def check_email_valid
    return add_error(:email_invalid) unless @params[:email][/\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i]
  end

  def find_lawyer_by_params
    @lawyer = Lawyer.find_by(name: @params[:name], email: @params[:email])
    return add_error(:lawyer_not_found_manual_sign_up) unless @lawyer
  end

  def check_lawyer_not_active
    return add_error(:lawyer_exist_please_sign_in) if @lawyer.confirmed?
  end

  def generate_reset_password_token
    @token = @lawyer.set_reset_password_token
  end

  def send_setting_password_mail
    CustomDeviseMailer.delay.send_setting_password_mail(@lawyer, @token)
  end

end
