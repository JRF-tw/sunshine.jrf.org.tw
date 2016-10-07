class Party::ChangePhoneFormObject
  include ActiveModel::Model

  attr_accessor :party, :unconfirmed_phone, :phone_varify_code
  attr_reader :phone_number

  validates :unconfirmed_phone, format: { with: /\A(0)(9)([0-9]{8})\z/ }, presence: true

  def initialize(party, params = nil)
    @party = party
    @phone_number = @party.phone_number
    self.unconfirmed_phone = params[:unconfirmed_phone] if params && params[:unconfirmed_phone]
  end

  def save
    return false unless valid?
    @party.update_attributes(unconfirmed_phone: unconfirmed_phone, phone_varify_code: phone_varify_code)
  end
end
