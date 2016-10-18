class Party::VerifyPhoneFormObject < BaseFormObject

  attr_accessor :phone_varify_code, :unconfirmed_phone

  validates :phone_varify_code, presence: true
  validate  :valid_varify_code, if: :has_varify_code?

  def initialize(party, params = nil)
    @party = party
    self.unconfirmed_phone = @party.unconfirmed_phone.value
    self.phone_varify_code = params[:phone_varify_code] if params && params[:phone_varify_code]
  end

  def save
    return false unless valid?
    @party.update_attributes(phone_number: unconfirmed_phone)
  end

  private

  def has_varify_code?
    phone_varify_code.present?
  end

  def valid_varify_code
    add_error(:wrong_verify_code) unless phone_varify_code == @party.phone_varify_code.value
  end
end
