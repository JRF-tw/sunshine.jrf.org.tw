class ScoreTopic
  attr_reader :list

  class << self
    def list_topic(scores_types, key)
      new.list[:scores_topics][scores_types][key]
    end

    def list_true_or_false_title(scores_types, main_key)
      new.list[:scores_topics][scores_types]["#{main_key}_title".to_sym]
    end

    def list_true_or_false_keys(scores_types, main_key)
      new.list[:scores_topics][scores_types][main_key].keys
    end

    def list_true_or_false_topic(scores_types, main_key, key)
      new.list[:scores_topics][scores_types][main_key][key]
    end

    def topic_type(key)
      new.list[:scores_topics][:topic_types][key]
    end
  end

  def initialize
    @list = Rails.application.config_for('settings').deep_symbolize_keys
  end
end
