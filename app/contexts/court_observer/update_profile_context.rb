class CourtObserver::UpdateProfileContext < BaseContext
  PERMITS = [:name, :phone_number, :school, :department_level, :student_number].freeze

  before_perform :assign_value

  def initialize(court_observer)
    @court_observer = court_observer
  end

  def perform(params)
    @params = permit_params(params[:court_observer] || params, PERMITS)
    run_callbacks :perform do
      return add_error(:data_update_fail, @court_observer.errors.full_messages.join("\n")) unless @court_observer.save
      true
    end
  end

  private

  def assign_value
    @court_observer.assign_attributes(@params)
  end
end
