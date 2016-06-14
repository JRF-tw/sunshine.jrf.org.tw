class Errors::Code

  STATUS = {
    error_code_not_defined: 400,
    data_create_fail: 400,
    data_update_fail: 400,
    data_delete_fail: 400,
    data_not_found: 400,
    date_blank: 400,
    lawyer_not_found: 400,
    lawyer_exist: 400,
    send_email_fail: 400,
    email_conflict: 400
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
