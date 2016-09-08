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
      return add_error(:wrong_password) unless @lawyer.update_with_password(@params)
      true
    end
  end

  private

  def check_email_valid
    return add_error(:email_invalid) unless @params[:email][/\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i]
  end

  def check_email_different
    return add_error(:email_conflict) if @params["email"] == @lawyer.email
  end

  def check_email_unique
    return add_error(:email_exist) if Lawyer.pluck(:email).include?(@params[:email])
  end

  def skip_devise_confirmation_notification
    @lawyer.skip_confirmation_notification!
  end

  def generate_confirmation_token
    token = Devise.token_generator.generate(@lawyer.class, :confirmation_token)[0]
    @lawyer.update_attributes(confirmation_sent_at: Time.zone.now, confirmation_token: token)
  end

  def send_reconfirmation_email
    CustomDeviseMailer.delay.resend_confirmation_instructions(@lawyer)
  end

end
