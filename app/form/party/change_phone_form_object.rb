class Party::ChangePhoneFormObject
  include ActiveModel::Model

  attr_accessor :party, :unconfirmed_phone
  attr_reader :phone_number

  validates :unconfirmed_phone, presence: true

  def initialize(party, params = nil)
    @party = party
    @phone_number = @party.phone_number
    self.unconfirmed_phone = params[:unconfirmed_phone] if params[:unconfirmed_phone]
  end
end
