class StoryTypes
  attr_reader :types

  class << self
    def list
      new.types[:story_types]
    end
  end

  def initialize
    @types = Rails.application.config_for('settings').deep_symbolize_keys
  end
end
