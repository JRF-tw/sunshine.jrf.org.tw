class Errors::Code

  STATUS = {
    error_code_not_defined: 400,
    data_create_fail: 400,
    data_update_fail: 400,
    data_delete_fail: 400,
    data_not_found: 400,
    date_blank: 400,
    password_invalid: 400,
    lawyer_not_found: 400,
    lawyer_exist: 400,
    observer_exist: 400,
    party_exist: 400,
    send_email_fail: 400,
    email_conflict: 400,
    without_policy_agreement: 400,
    retry_verify_count_out_range: 400,
    story_subscriber_failed: 400,
    story_subscriber_valid_failed: 401
  }.freeze

  class << self
    def exists?(key)
      status(key).present?
    end

    def status(key)
      STATUS[key.to_sym]
    end

    def desc(key)
      I18n.t("errors.#{key}")
    end
  end

end
