class Party::SetPhoneContext < BaseContext
  PERMITS = [:unconfirmed_phone].freeze
  SENDINGLIMIT = 2

  before_perform :init_form_object
  before_perform :check_sms_send_count
  after_perform  :assign_verify_code
  after_perform  :set_unconfirm
  after_perform  :build_message
  after_perform  :send_sms
  after_perform  :increment_sms_count
  after_perform  :auto_delete_unconfirmed_phone

  def initialize(party, params)
    @party = party
    @params = permit_params(params[:phone_form] || params, PERMITS)
  end

  def perform
    run_callbacks :perform do
      add_error(:data_update_fail, @form_object.full_error_messages) unless @form_object.save
    end
    @form_object
  end

  private

  def init_form_object
    @form_object = Party::ChangePhoneFormObject.new(@party, @params)
  end

  def check_sms_send_count
    add_error(:send_sms_too_frequent) if @party.sms_sent_count.value >= SENDINGLIMIT
  end

  def generate_verify_code
    rand(1..9999).to_s.rjust(4, '0')
  end

  def assign_verify_code
    @party.phone_varify_code = generate_verify_code
  end

  def set_unconfirm
    @party.phone_unconfirm!
  end

  def build_message
    link = verify_party_phone_url(host: Setting.host)
    @message = "當事人手機驗證簡訊 發送至 #{@params[:unconfirmed_phone]}: 認證碼 : #{@verify_code}, #{link}"
  end

  def send_sms
    SmsService.send_async(@params[:unconfirmed_phone], @message)
  end

  def increment_sms_count
    @party.sms_sent_count.increment
  end

  def auto_delete_unconfirmed_phone
    @party.delay_until(1.hour.from_now).update_columns(unconfirmed_phone: nil)
  end

end
