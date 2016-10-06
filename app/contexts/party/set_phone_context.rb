class Party::SetPhoneContext < BaseContext
  SENDINGLIMIT = 2

  before_perform  :check_phone_format
  before_perform  :check_phone_not_the_same
  before_perform  :check_unexist_phone_number
  before_perform  :check_unexist_unconfirmed_phone
  before_perform  :check_sms_send_count
  before_perform  :generate_verify_code
  before_perform  :assign_value
  after_perform   :set_unconfirm
  after_perform   :build_message
  after_perform   :send_sms
  after_perform   :increment_sms_count

  def initialize(phone_form)
    @phone_form = phone_form
    @party = @phone_form.party
  end

  def perform
    run_callbacks :perform do
      return add_error(:data_update_fail, @phone_form.errors.full_messages.join(',').to_s) unless @phone_form.save
      true
    end
  end

  private

  def check_phone_format
    return add_error(:invalid_phone_number, @phone_form.errors.full_messages.join(",").to_s) unless @phone_form.valid?
  end

  def check_phone_not_the_same
    return add_error(:phone_number_conflict) if @phone_form.phone_number == @phone_form.unconfirmed_phone
  end

  def check_unexist_phone_number
    return add_error(:phone_number_exist) if Party.pluck(:phone_number).include?(@phone_form.unconfirmed_phone)
  end

  def check_unexist_unconfirmed_phone
    return add_error(:phone_number_confirming) if (Party.all.map { |n| n if n.unconfirmed_phone.value == @phone_form.unconfirmed_phone }).compact.present?
  end

  def check_sms_send_count
    return add_error(:send_sms_too_frequent) if @party.sms_sent_count.value >= SENDINGLIMIT
  end

  def generate_verify_code
    @verify_code = rand(1..9999).to_s.rjust(4, '0')
  end

  def assign_value
    @phone_form.phone_varify_code = @verify_code
  end

  def set_unconfirm
    @party.phone_unconfirm!
  end

  def build_message
    link = verify_party_phone_url(host: Setting.host)
    @message = "當事人手機驗證簡訊 發送至 #{@phone_form.unconfirmed_phone}: 認證碼 : #{@phone_form.phone_varify_code}, #{link}"
  end

  def send_sms
    SmsService.send_async(@phone_form.unconfirmed_phone, @message)
  end

  def increment_sms_count
    @party.sms_sent_count.increment
  end

end
