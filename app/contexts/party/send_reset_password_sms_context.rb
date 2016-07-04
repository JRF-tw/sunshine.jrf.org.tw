class Party::SendResetPasswordSmsContext < BaseContext
  include Rails.application.routes.url_helpers

  PERMITS = [:identify_number, :phone_number].freeze

  before_perform  :find_party
  before_perform  :generate_reset_password_token
  before_perform  :build_message
  after_perform   :send_sms

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
    @party = Party.find_by(@params)
    return add_error(:data_not_found, "沒有此當事人資訊") unless @party
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
end
