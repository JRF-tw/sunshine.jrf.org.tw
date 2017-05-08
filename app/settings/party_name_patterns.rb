class PartyNamePatterns
  attr_reader :list

  class << self
    def main_role
      new.list[:party_parse_pattern][:mail_role]
    end

    def sub_role
      new.list[:party_parse_pattern][:sub_role]
    end
  end

  def initialize
    @list = Rails.application.config_for('settings').deep_symbolize_keys
  end
end
