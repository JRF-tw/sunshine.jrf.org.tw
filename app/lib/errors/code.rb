class Errors::Code

  STATUS = {
    error_code_not_defined: 400,
    params_required: 400,
    data_not_found: 404,
    value_blank: 400,
    validates_fail: 400,
    data_create_fail: 400,
    data_update_fail: 400,
    data_delete_fail: 400
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
