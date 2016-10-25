class CourtObserver::ChangeEmailContext < BaseContext
  PERMITS = [:email, :current_password].freeze

  before_perform :check_email_valid
  before_perform :check_email_different
  before_perform :check_email_unique
  before_perform :skip_devise_confirmation_notification
  after_perform :generate_confirmation_token
  after_perform :send_reconfirmation_email

  def initialize(court_observer)
    @court_observer = court_observer
  end

  def perform(params)
    @params = permit_params(params[:court_observer] || params, PERMITS)
    run_callbacks :perform do
      return add_error_and_assign_email(:wrong_password) unless @court_observer.update_with_password(@params)
      true
    end
  end

  private

  def add_error_and_assign_email(error_key)
    @court_observer.assign_attributes(email: @params[:email])
    add_error(error_key.to_sym)
  end

  def check_email_valid
    return add_error_and_assign_email(:email_pattern_invalid) unless @params[:email][/\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i]
  end

  def check_email_different
    return add_error_and_assign_email(:email_conflict) if @params['email'] == @court_observer.email
  end

  def check_email_unique
    return add_error_and_assign_email(:email_exist) if CourtObserver.pluck(:email).include?(@params[:email])
  end

  def skip_devise_confirmation_notification
    @court_observer.skip_confirmation_notification!
  end

  def generate_confirmation_token
    token = Devise.token_generator.generate(@court_observer.class, :confirmation_token)[0]
    @court_observer.update_attributes(confirmation_sent_at: Time.zone.now, confirmation_token: token)
  end

  def send_reconfirmation_email
    CustomDeviseMailer.delay.resend_confirmation_instructions(@court_observer)
  end
end
