class CourtObserver::ChangeEmailContext < BaseContext
  PERMITS = [:email, :current_password].freeze

  before_perform :check_email_different

  def initialize(court_observer)
    @court_observer = court_observer
  end

  def perform(params)
    @params = permit_params(params[:court_observer] || params, PERMITS)
    run_callbacks :perform do
      return add_error(:data_update_fail, "email 更新失敗") unless @court_observer.update_with_password(@params)
      true
    end
  end

  private

  def check_email_different
    return add_error(:email_conflict, "email 不可與原本相同") if @params["email"] == @court_observer.email
  end

end
