class Party::ChangePhoneFormObject < BaseFormObject
  attr_accessor :unconfirmed_phone
  attr_reader :phone_number

  validates :unconfirmed_phone, format: { with: /\A(0)(9)([0-9]{8})\z/ }, presence: true
  validate :unexist_phone_number, :unexist_unconfirmed_phone

  def initialize(party, params = nil)
    @party = party
    @phone_number = @party.phone_number
    self.unconfirmed_phone = params[:unconfirmed_phone] if params && params[:unconfirmed_phone]
  end

  def unexist_phone_number
    if @party.phone_number == unconfirmed_phone
      add_error(:phone_number_conflict)
    elsif Party.pluck(:phone_number).include?(unconfirmed_phone)
      add_error(:phone_number_exist)
    end
  end

  def unexist_unconfirmed_phone
    add_error(:phone_number_confirming) if (Party.all.map { |n| n if n.unconfirmed_phone.value == unconfirmed_phone }).compact.present? && unconfirmed_phone.present?
  end

  def save
    return false unless valid?
    @party.unconfirmed_phone = unconfirmed_phone
  end
end
