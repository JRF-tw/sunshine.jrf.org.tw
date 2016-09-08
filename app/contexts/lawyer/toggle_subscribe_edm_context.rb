class Lawyer::ToggleSubscribeEdmContext < BaseContext
  before_perform :assign_value

  def initialize(lawyer)
    @lawyer = lawyer
  end

  def perform
    run_callbacks :perform do
      return add_error(:subscribe_fail) unless @lawyer.save
      true
    end
  end

  private

  def assign_value
    @lawyer.assign_attributes(subscribe_edm: !@lawyer.subscribe_edm)
  end
end
