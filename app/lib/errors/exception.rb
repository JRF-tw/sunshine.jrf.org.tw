class Errors::Exception < RuntimeError
  attr_accessor :key, :info

  def initialize(key, info = {})
    self.key = key
    self.info = info
  end

  def message
    info.delete(:message) || (Code.desc(key) + (Rails.env.production? ? "" : info.inspect))
  end

  def to_hash
    {
      message:  message,
      info:     info,
      key:      key
    }
  end
end
