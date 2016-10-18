class BaseFormObject
  include ActiveModel::Model

  def add_error(key, custom_message = nil)
    raise_error!(:error_code_not_defined, custom_message: custom_message) unless Errors::Code.exists?(key)
    @errors ||= {}
    @errors[key.to_sym] ||= []
    @errors[key.to_sym] << (custom_message || Errors::Code.desc(key))
    false
  end

  def errors_messaage
    message = []
    errors.messages.each_value { |error| message << error  }
    message.join(",").to_s
  end
end
