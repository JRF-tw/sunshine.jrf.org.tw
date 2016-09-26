class PartyPhoneFormObject
  include ActiveModel::Model

  attr_accessor :party, :unconfirmed_phone, :phone_varify_code
  attr_reader :phone_number

  def initialize(party, params = nil)
    @party = party
    @phone_number = @party.phone_number
    self.unconfirmed_phone = params[:unconfirmed_phone] if params[:unconfirmed_phone]
    self.phone_varify_code = params[:phone_varify_code] if params[:phone_varify_code]
  end
end
