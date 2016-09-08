class CourtObserver::ToggleSubscribeEdmContext < BaseContext
  before_perform :assign_value

  def initialize(court_observer)
    @court_observer = court_observer
  end

  def perform
    run_callbacks :perform do
      return add_error(:subscribe_fail) unless @court_observer.save
      true
    end
  end

  private

  def assign_value
    @court_observer.assign_attributes(subscribe_edm: !@court_observer.subscribe_edm)
  end
end
