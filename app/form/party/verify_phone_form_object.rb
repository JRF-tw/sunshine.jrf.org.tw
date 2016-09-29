class Party::VerifyPhoneFormObject
  include ActiveModel::Model

  attr_accessor :party, :phone_varify_code, :unconfirmed_phone

  validates :phone_varify_code, presence: true

  def initialize(party, params = nil)
    @party = party
    self.unconfirmed_phone = @party.unconfirmed_phone.value
    self.phone_varify_code = params[:phone_varify_code] if params[:phone_varify_code]
  end
end
