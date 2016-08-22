class CustomDeviseMailer < Devise::Mailer
  helper :application
  include Devise::Controllers::UrlHelpers
  default template_path: "custom_devise_mailer"
  default from: Setting.mailer.default_sender

  def send_setting_password_mail(resource, token)
    @resource = resource
    @token = token
    mail(to: @resource.email, from: Setting.mailer.default_sender, subject: "設定您在司法陽光網的密碼")
  end

  def resend_confirmation_instructions(resource, token)
    @resource = resource
    @token = token
    mail(to: @resource.unconfirmed_email, from: Setting.mailer.default_sender, subject: "更改您在司法陽光網的電子郵件信箱")
  end
end
