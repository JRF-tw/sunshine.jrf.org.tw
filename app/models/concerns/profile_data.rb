module ProfileData
  extend ActiveSupport::Concern

  included do
    send(:have_relation_data)
  end

  module ClassMethods

    def have_relation_data
      has_many :educations, as: :owner, dependent: :destroy
      has_many :careers, as: :owner, dependent: :destroy
      has_many :licenses, as: :owner, dependent: :destroy
      has_many :awards, as: :owner, dependent: :destroy
      has_many :punishments, as: :owner, dependent: :destroy
      has_many :reviews, as: :owner, dependent: :destroy
      has_many :articles, as: :owner, dependent: :destroy
    end

  end
end
