class Defendant::ResendPhoneVerifySmsContext < BaseContext

  before_perform  :check_verify_code
  before_perform  :check_sms_send_count
  after_perform   :build_message
  after_perform   :send_sms
  after_perform   :record_sms_count

  def initialize(defendant)
    @defendant = defendant
  end

  def perform
    run_callbacks :perform do
      true
    end
  end

  private

  def check_verify_code
    return add_error(:data_update_fail, "請先設定手機號碼") unless @defendant.phone_varify_code.value
  end

  def check_sms_send_count
    return add_error(:data_update_fail, "五分鐘內只能寄送兩次簡訊") if @defendant.sms_sent_count.value >= 2
  end

  def build_message
    link = verify_defendants_phone_url(host: Setting.host)
    @message = "當事人手機驗證簡訊 發送至 #{@defendant.unconfirmed_phone.value}: 認證碼 : #{@defendant.phone_varify_code.value}, #{SlackService.render_link(link, "認證手機網址")}"
  end

  def send_sms
    SmsService.send_async(@defendant.unconfirmed_phone.value, @message)
  end

  def record_sms_count
    @defendant.sms_sent_count.increment
  end
end

