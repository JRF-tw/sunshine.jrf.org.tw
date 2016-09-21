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
      unless @lawyer.update_with_password(@params)
        assign_email
        return add_error(:wrong_password)
      end
      true
    end
  end

  private

  def assign_email
    @lawyer.assign_attributes(email: @params[:email])
  end

  def check_email_valid
    unless @params[:email][/\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i]
      assign_email
      return add_error(:email_pattern_invalid)
    end
  end

  def check_email_different
    if @params["email"] == @lawyer.email
      assign_email
      return add_error(:email_conflict)
    end
  end

  def check_email_unique
    if Lawyer.pluck(:email).include?(@params[:email])
      assign_email
      return add_error(:email_exist)
    end
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
