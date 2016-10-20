class CrawlerKinds
  attr_reader :list

  class << self
    def list
      new.list[:crawler_kinds]
    end
  end

  def initialize
    @list = Rails.application.config_for("settings").deep_symbolize_keys
  end
end
