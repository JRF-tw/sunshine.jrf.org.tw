class Party::SendResetPasswordSmsContext < BaseContext
  include Rails.application.routes.url_helpers

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
      return add_error(:data_update_fail, "未能重設密碼") unless can_reset_password?
      true
    end
  end

  private

  def find_party
    @party = Party.find_by_identify_number(@params[:identify_number])
    return add_error(:data_not_found, "沒有此當事人資訊") unless @party
  end

  def check_phone_number_verified
    return add_error(:without_verify, "手機號碼尚未驗證 <a href='/party/appeal/new'>人工申訴</a>") if @params[:phone_number] == @party.unconfirmed_phone.value
  end

  def check_phone_number_exist
    return add_error(:data_not_found, "手機號碼輸入錯誤") unless @party.phone_number == @params[:phone_number]
  end

  def generate_reset_password_token
    @token = @party.set_reset_password_token
  end

  def can_reset_password?
    @party.reset_password_token.present? && @party.reset_password_sent_at.present?
  end

  def build_message
    link = edit_party_password_url(reset_password_token: @token, host: Setting.host)
    @message = "您剛剛在司法陽光網請求重設您的當事人帳號密碼。請點選以下連結重新設定您的密碼：#{SlackService.render_link(link, "重設密碼網址")} 如果您並未送出這個請求，請忽略此簡訊。"
  end

  def send_sms
    SmsService.send_async(@party.phone_number, @message)
  end

  def check_sms_send_count
    return add_error(:data_update_fail, "五分鐘內只能寄送兩次簡訊") if @party.sms_sent_count.value >= SENDINGLIMIT
  end

  def record_sms_count
    @party.sms_sent_count.increment
  end

end
