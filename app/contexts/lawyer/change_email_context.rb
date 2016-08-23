class Lawyer::ChangeEmailContext < BaseContext
  PERMITS = [:email, :current_password].freeze

  before_perform :check_email_valid
  before_perform :check_email_different
  before_perform :check_email_unique
  before_perform :skip_devise_confirmation_notification
  after_perform :generate_confirmation_token
  after_perform :send_reconfirmation_email

  def initialize(lawyer)
    @lawyer = lawyer
  end

  def perform(params)
    @params = permit_params(params[:lawyer] || params, PERMITS)
    run_callbacks :perform do
      return add_error(:data_update_fail, "密碼錯誤") unless @lawyer.update_with_password(@params)
      true
    end
  end

  private

  def check_email_valid
    return add_error(:data_invalid, "email 的格式是無效的") unless @params[:email][/\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i]
  end

  def check_email_different
    return add_error(:email_conflict, "email 不可與原本相同") if @params["email"] == @lawyer.email
  end

  def check_email_unique
    return add_error(:lawyer_exist, "email 已經被使用") if Lawyer.pluck(:email).include?(@params[:email])
  end

  def skip_devise_confirmation_notification
    @lawyer.skip_confirmation_notification!
  end

  def generate_confirmation_token
    @lawyer.confirmation_token = @token = Devise.token_generator.generate(@lawyer.class, :confirmation_token)[0]
    @lawyer.confirmation_sent_at = Time.zone.now
    @lawyer.save
  end

  def send_reconfirmation_email
    CustomDeviseMailer.delay.resend_confirmation_instructions(@lawyer, @token)
  end

end
