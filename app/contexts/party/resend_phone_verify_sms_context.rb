class Party::ResendPhoneVerifySmsContext < BaseContext

  before_perform  :check_verify_code
  before_perform  :check_sms_send_count
  after_perform   :build_message
  after_perform   :send_sms
  after_perform   :record_sms_count

  def initialize(party)
    @party = party
  end

  def perform
    run_callbacks :perform do
      true
    end
  end

  private

  def check_verify_code
    return add_error(:party_without_phone_number) unless @party.phone_varify_code.value
  end

  def check_sms_send_count
    return add_error(:send_sms_too_frequent) if @party.sms_sent_count.value >= 2
  end

  def build_message
    link = verify_party_phone_url(host: Setting.host)
    @message = "當事人手機驗證簡訊 發送至 #{@party.unconfirmed_phone.value}: 認證碼 : #{@party.phone_varify_code.value}, #{link}"
  end

  def send_sms
    SmsService.send_async(@party.unconfirmed_phone.value, @message)
  end

  def record_sms_count
    @party.sms_sent_count.increment
  end
end
