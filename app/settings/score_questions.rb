class ScoreQuestions
  attr_reader :list

  class << self
    def list(scores_types, key)
      new.list[:scores_questions][scores_types][key]
    end
  end

  def initialize
    @list = Rails.application.config_for('settings').deep_symbolize_keys
  end
end
