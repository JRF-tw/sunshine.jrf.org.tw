module HiddenOrNot
  extend ActiveSupport::Concern

  included do
    send(:hidden_or_not)
  end

  module ClassMethods

    def hidden_or_not
      scope :hidden, -> { where(is_hidden: true) }
      scope :shown, -> { where(is_hidden: [false, nil]) }
    end

  end

end
