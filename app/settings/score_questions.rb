class ScoreQuestions
  attr_reader :list

  class << self
    def list(scores_types, key)
      new.list[:scores_questions][scores_types][key]
    end

    def need_show_up_level_title(key)
      new.list[:scores_questions][:show_up_level_title][key]
    end

    def question_type(key)
      new.list[:scores_questions][:question_types][key]
    end
  end

  def initialize
    @list = Rails.application.config_for('settings').deep_symbolize_keys
  end
end
