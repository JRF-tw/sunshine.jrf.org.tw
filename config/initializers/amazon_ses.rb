ActionMailer::Base.add_delivery_method :ses, AWS::SES::Base,
  access_key_id: Setting.aws.access_key_id,
  secret_access_key: Setting.aws.secret_access_key
