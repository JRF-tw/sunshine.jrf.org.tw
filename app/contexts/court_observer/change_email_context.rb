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
      unless @court_observer.update_with_password(@params)
        assign_email
        return add_error(:wrong_password)
      end
      true
    end
  end

  private

  def assign_email
    @court_observer.assign_attributes(email: @params[:email])
  end

  def check_email_valid
    unless @params[:email][/\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i]
      assign_email
      return add_error(:email_pattern_invalid)
    end
  end

  def check_email_different
    if @params["email"] == @court_observer.email
      assign_email
      return add_error(:email_conflict)
    end
  end

  def check_email_unique
    if CourtObserver.pluck(:email).include?(@params[:email])
      assign_email
      return add_error(:email_exist)
    end
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
