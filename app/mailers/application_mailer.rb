class ApplicationMailer < ActionMailer::Base
  default from: Setting.mailer.default_sender
  layout 'mailer'
end
