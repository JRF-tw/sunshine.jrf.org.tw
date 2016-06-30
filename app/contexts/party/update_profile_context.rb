class Party::UpdateProfileContext < BaseContext
  PERMITS = [:name].freeze

  before_perform :assign_value

  def initialize(party)
    @party = party
  end

  def perform(params)
    @params = permit_params(params[:party] || params, PERMITS)
    run_callbacks :perform do
      return add_error(:data_update_fail, @party.errors.full_messages.join("\n")) unless @party.save
      true
    end
  end

  private

  def assign_value
    @party.assign_attributes(@params)
  end
end

