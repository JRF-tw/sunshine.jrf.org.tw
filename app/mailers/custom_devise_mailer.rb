class CustomDeviseMailer < Devise::Mailer
  helper :application
  include Devise::Controllers::UrlHelpers
  default template_path: "custom_devise_mailer"
  default from: Setting.mailer.default_sender

  def send_setting_password_mail(resource, token)
    @resource = resource
    @token = token
    mail(to: @resource.email, from: Setting.mailer.default_sender, subject: "律師第一次設定密碼")
  end
end
