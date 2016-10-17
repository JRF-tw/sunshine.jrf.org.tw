class Party::VerifyPhoneFormObject < BaseFormObject

  attr_accessor :party, :phone_varify_code, :unconfirmed_phone

  validates :phone_varify_code, presence: true

  def initialize(party, params = nil)
    @party = party
    self.unconfirmed_phone = @party.unconfirmed_phone.value
    self.phone_varify_code = params[:phone_varify_code] if params && params[:phone_varify_code]
  end

  def save
    return false unless valid?
    @party.update_attributes(phone_number: unconfirmed_phone)
  end
end
