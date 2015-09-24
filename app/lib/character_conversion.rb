module CharacterConversion
  cattr_accessor :params_utf8

  def get_params_utf8(keys = {})
    self.params_utf8 = {}
    keys.each do |k|
      self.params_utf8[k.to_sym] = params[k.to_sym].present? ? char_force_utf8(params[k.to_sym]) : nil
    end
    params_utf8
  end

  def char_force_utf8(str)
    begin
      outstr = str.to_s.force_encoding(Encoding::UTF_8).encode(Encoding::UTF_8)
    rescue Encoding::UndefinedConversionError
      outstr = nil
    end
    outstr
  end

end
