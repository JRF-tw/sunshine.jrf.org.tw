class Party::ChangePhoneFormObject < BaseFormObject
  attr_accessor :phone_varify_code, :unconfirmed_phone
  attr_reader :phone_number

  validates :unconfirmed_phone, format: { with: /\A(0)(9)([0-9]{8})\z/ }, presence: true
  validate :phone_not_the_same, :unexist_phone_number, :unexist_unconfirmed_phone

  def initialize(party, params = nil)
    @party = party
    @phone_number = @party.phone_number 
    @params = params
  end

  def phone_not_the_same
    add_error(:phone_number_conflict) if @party.phone_number == @params[:unconfirmed_phone]
  end

  def unexist_phone_number
    add_error(:phone_number_exist) if Party.pluck(:phone_number).include?(@params[:unconfirmed_phone])
  end

  def unexist_unconfirmed_phone
    add_error(:phone_number_confirming) if (Party.all.map { |n| n if n.unconfirmed_phone.value == @params[:unconfirmed_phone] }).compact.present?
  end

  def save
    return false unless valid?
    @party.update_attributes(unconfirmed_phone: @params[:unconfirmed_phone], phone_varify_code: phone_varify_code)
  end
end
