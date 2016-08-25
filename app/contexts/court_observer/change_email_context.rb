class CourtObserver::ChangeEmailContext < BaseContext
  PERMITS = [:email, :current_password].freeze

  before_perform :check_email_valid
  before_perform :check_email_different
  before_perform :check_email_uniqe

  def initialize(court_observer)
    @court_observer = court_observer
  end

  def perform(params)
    @params = permit_params(params[:court_observer] || params, PERMITS)
    run_callbacks :perform do
      return add_error(:data_update_fail, "密碼錯誤") unless @court_observer.update_with_password(@params)
      true
    end
  end

  private

  def check_email_valid
    return add_error(:data_invalid, "email 的格式是無效的") unless @params[:email][/\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i]
  end

  def check_email_different
    return add_error(:email_conflict, "email 不可與原本相同") if @params["email"] == @court_observer.email
  end

  def check_email_uniqe
    return add_error(:observer_exist, "email 已經被使用") if CourtObserver.pluck(:email).include?(@params[:email])
  end

end
