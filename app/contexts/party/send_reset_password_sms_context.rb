class Party::SendResetPasswordSmsContext < BaseContext
  PERMITS = [:identify_number, :phone_number].freeze
  SENDINGLIMIT = 2

  before_perform  :find_party
  before_perform  :check_phone_number_verified
  before_perform  :check_phone_number_exist
  before_perform  :check_sms_send_count
  before_perform  :generate_reset_password_token
  before_perform  :build_message
  after_perform   :send_sms
  after_perform   :record_sms_count

  def initialize(params)
    @params = permit_params(params[:party] || params, PERMITS)
  end

  def perform
    run_callbacks :perform do
      return add_error(:cant_reset_password) unless can_reset_password?
      true
    end
  end

  private

  def find_party
    @party = Party.find_by_identify_number(@params[:identify_number])
    return add_error(:party_not_found) unless @party
  end

  def check_phone_number_verified
    return add_error(:phone_number_not_verify) if @params[:phone_number] == @party.unconfirmed_phone
  end

  def check_phone_number_exist
    return add_error(:wrong_phone_number) unless @party.phone_number == @params[:phone_number]
  end

  def generate_reset_password_token
    @token = @party.set_reset_password_token
  end

  def can_reset_password?
    @party.reset_password_token.present? && @party.reset_password_sent_at.present?
  end

  def build_message
    link = edit_party_password_url(reset_password_token: @token, host: Setting.host)
    @message = "您剛剛在司法陽光網請求重設您的當事人帳號密碼。請點選以下連結重新設定您的密碼：#{SlackService.render_link(link, '重設密碼網址')} 如果您並未送出這個請求，請忽略此簡訊。"
  end

  def send_sms
    SmsService.send_async(@party.phone_number, @message)
  end

  def check_sms_send_count
    return add_error(:send_sms_too_frequent) if @party.sms_sent_count.value >= SENDINGLIMIT
  end

  def record_sms_count
    @party.sms_sent_count.increment
  end

end
