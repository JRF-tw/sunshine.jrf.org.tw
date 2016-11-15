class Party::SelfDeleteContext < BaseContext

  def self.perform(party)
    party.destroy unless party.confirmed? && party.phone_number
  end

end
