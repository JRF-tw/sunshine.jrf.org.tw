class BaseFormObject
  include ActiveModel::Model

  def add_error(key, custom_message = nil)
    raise_error!(:error_code_not_defined, custom_message: custom_message) unless Errors::Code.exists?(key)
    @errors ||= {}
    @errors[key.to_sym] ||= []
    @errors[key.to_sym] << (custom_message || Errors::Code.desc(key))
    false
  end

  def full_error_messages
    error_messages = []
    errors.messages.map { |error_key, message| error_messages << error_message(error_key, message) }
    error_messages.join(", ")
  end

  def error_message(error_key, message)
    error_key_humanize = error_key.to_s.tr(".", "_").humanize
    error_key_to_model_attr = self.class.human_attribute_name(error_key)

    if error_key_humanize == error_key_to_model_attr
      message
    else
      I18n.t(:"errors.format", default:  "%{error_key} %{message}",
                               attribute: error_key_to_model_attr,
                               message:   message.join(", "))
    end
  end
end
