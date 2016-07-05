# == Schema Information
#
# Table name: story_subscriptions
#
#  id              :integer          not null, primary key
#  story_id        :integer
#  subscriber_id   :integer
#  subscriber_type :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class StorySubscription < ActiveRecord::Base
  belongs_to :story
  belongs_to :subscriber, polymorphic: true

  validates :story_id, uniqueness: { scope: [:subscriber_id, :subscriber_type] }
end
