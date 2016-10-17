class Party::SetPhoneContext < BaseContext
  PERMITS = [:unconfirmed_phone].freeze
  SENDINGLIMIT = 2

  before_perform  :init_form_object
  before_perform  :check_phone_form_valid
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

  def initialize(party)
    @party = party
  end

  def perform(params)
    @params = permit_params(params[:party] || params, PERMITS)
    run_callbacks :perform do
      return add_error(:data_update_fail, @form_object.errors.full_messages.join(',').to_s) unless @form_object.save
      true
    end
  end

  private

  def init_form_object
    @form_object = Party::ChangePhoneFormObject.new(@party, @params)
  end

  def check_phone_form_valid
    return add_error(:invalid_phone_number, @form_object.errors.full_messages.join(",").to_s) unless @form_object.valid?
  end

  def check_sms_send_count
    return add_error(:send_sms_too_frequent) if @party.sms_sent_count.value >= SENDINGLIMIT
  end

  def generate_verify_code
    @verify_code = rand(1..9999).to_s.rjust(4, '0')
  end

  def assign_value
    @form_object.phone_varify_code = @verify_code
  end

  def set_unconfirm
    @party.phone_unconfirm!
  end

  def build_message
    link = verify_party_phone_url(host: Setting.host)
    @message = "當事人手機驗證簡訊 發送至 #{@params[:unconfirmed_phone]}: 認證碼 : #{@form_object.phone_varify_code}, #{link}"
  end

  def send_sms
    SmsService.send_async(@params[:unconfirmed_phone], @message)
  end

  def increment_sms_count
    @party.sms_sent_count.increment
  end

end
