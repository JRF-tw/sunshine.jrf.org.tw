class CourtObserver::RegisterCheckContext < BaseContext
  PERMITS = [:name, :email, :password, :password_confirmation].freeze

  before_perform :check_observer_params_exist
  before_perform :check_email_valid
  before_perform :check_password_valid
  before_perform :check_observer_status
  before_perform :check_agree_policy

  def initialize(params)
    @params = permit_params(params[:court_observer] || params, PERMITS)
    @params[:policy_agreement] = true if params[:policy_agreement] == '1'
  end

  def perform
    run_callbacks :perform do
      true
    end
  end

  private

  def check_agree_policy
    return add_error(:without_policy_agreement) unless @params[:policy_agreement]
  end

  def check_observer_params_exist
    add_error(:name_blank) if @params[:name].blank?
    add_error(:email_blank) if @params[:email].blank?
    add_error(:password_blank) if @params[:password].blank?
    add_error(:password_confirmation_blank) if @params[:password_confirmation].blank?

    return false if errors.present?
  end

  def check_email_valid
    return add_error(:email_pattern_invalid) unless @params[:email][/\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i]
  end

  def check_password_valid
    add_error(:password_less_than_minimum) if @params[:password].size < 8
    add_error(:password_not_match_confirmation) if @params[:password] != @params[:password_confirmation]
    return false if errors.present?
  end

  def check_observer_status
    @observer = CourtObserver.find_by_email(@params[:email])
    if @observer && @observer.confirmed?
      return add_error(:observer_already_confirm)
    elsif @observer
      @observer.send_confirmation_instructions
      return add_error(:observer_already_sign_up)
    end
  end
end
