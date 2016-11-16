class Party::DeleteUnconfirmContext < BaseContext
  EXPIRETIME = 1.day

  class << self
    def perform(party)
      delay_for(EXPIRETIME).delete_unconfirm_party(party)
    end

    def delete_unconfirm_party(party)
      party.destroy unless party.confirmed? && party.phone_number
    end
  end

end
