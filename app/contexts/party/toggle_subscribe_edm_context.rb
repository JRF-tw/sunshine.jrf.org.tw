class Party::ToggleSubscribeEdmContext < BaseContext
  before_perform :check_email
  before_perform :check_confirm
  before_perform :assign_value

  def initialize(party)
    @party = party
  end

  def perform
    run_callbacks :perform do
      return add_error(:subscribe_fail) unless @party.save
      true
    end
  end

  private

  def check_email
    return add_error(:subscriber_email_not_confirm) unless @party.confirmed?
  end

  def check_confirm
    return add_error(:subscriber_without_email) unless @party.email.present?
  end

  def assign_value
    @party.assign_attributes(subscribe_edm: !@party.subscribe_edm)
  end
end
