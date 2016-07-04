class Party::SetPhoneContext < BaseContext
  PERMITS = [:phone_number].freeze

  before_perform  :check_phone
  before_perform  :check_phone_format
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
      return add_error(:data_create_fail, @party.errors.full_messages.join(",").to_s) unless @party.save
      true
    end
  end

  private

  def check_phone
    return add_error(:data_update_fail, "手機號碼為必填欄位") unless @params[:phone_number].present?
  end

  def check_phone_format
    return add_error(:data_update_fail, "手機號碼格式錯誤") unless @params[:phone_number] =~ /\A(0)(9)([0-9]{8})\z/
  end

  def check_unexist_phone_number
    return add_error(:data_update_fail, "該手機號碼已註冊") if Party.pluck(:phone_number).include?(@params[:phone_number])
  end

  def check_unexist_unconfirmed_phone
    return add_error(:data_update_fail, "該手機號碼正等待驗證中") if (Party.all.map { |n| n if n.unconfirmed_phone.value == @params[:phone_number] }).compact.present?
  end

  def check_sms_send_count
    return add_error(:data_update_fail, "五分鐘內只能寄送兩次簡訊") if @party.sms_sent_count.value >= 2
  end

  def generate_verify_code
    @verify_code = rand(1..9999).to_s.rjust(4, "0")
  end

  def assign_value
    @party.unconfirmed_phone = @params[:phone_number]
    @party.phone_varify_code = @verify_code
  end

  def set_unconfirm
    @party.phone_unconfirm!
  end

  def build_message
    link = verify_party_phone_url(host: Setting.host)
    @message = "當事人手機驗證簡訊 發送至 #{@party.unconfirmed_phone.value}: 認證碼 : #{@party.phone_varify_code.value}, #{SlackService.render_link(link, "認證手機網址")}"
  end

  def send_sms
    SmsService.send_async(@party.unconfirmed_phone.value, @message)
  end

  def increment_sms_count
    @party.sms_sent_count.increment
  end
end
