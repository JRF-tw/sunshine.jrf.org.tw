class Party::SendResetPasswordSmsContext < BaseContext
  include Rails.application.routes.url_helpers

  PERMITS = [:identify_number, :phone_number].freeze

  before_perform  :find_party
  before_perform  :check_phone_number_exist_and_verified
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

  def check_phone_number_exist_and_verified
    return add_error(:without_verify, "手機號碼尚未驗證 <a href='/party/appeal/new'>人工申訴</a>") if @params[:phone_number] == @party.unconfirmed_phone.value
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
    @message = "當事人密碼重設信件 發送至 #{@party.phone_number}: #{SlackService.render_link(link, "重設密碼網址")}"
  end

  def send_sms
    SmsService.send_async(@party.phone_number, @message)
  end

  def check_sms_send_count
    return add_error(:data_update_fail, "五分鐘內只能寄送兩次簡訊") if @party.sms_sent_count.value >= 2
  end

  def record_sms_count
    @party.sms_sent_count.increment
  end

end
