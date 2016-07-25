class CourtObserver::SendSetPasswordEmailContext < BaseContext

  def initialize(court_observer)
    @court_observer = court_observer
  end

  def perform
    run_callbacks :perform do
      @court_observer.send_reset_password_instructions
    end
  end

end
