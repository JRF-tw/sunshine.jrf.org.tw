class SmsService
  attr_accessor :phone

  class << self
    def send_to(phone, text)
      SmsService.new(phone).send_by_twilio(text)
    end

    def send_async(phone, text)
      SmsService.delay.send_to(phone, text)
    end
  end

  def initialize(phone)
    phone = "+886#{phone[1..-1]}" if phone.index("0") == 0
    self.phone = phone
  end

  def send_by_twilio(text)
    SlackService.fake_defendant_reset_password_notify_async(text)

    # TODO
    # Twilio::REST::Client.new(Setting.twilio.sid, Setting.twilio.token).account.messages.create({
    #   from: '+12564102237',
    #   to:   phone,
    #   body: format_text(text)
    # })
  end

  private

  def format_text(text)
    Rails.env.production? ? text : "[#{Rails.env}] #{text}"
  end
end
