# == Schema Information
#
# Table name: story_relations
#
#  id          :integer          not null, primary key
#  story_id    :integer
#  people_id   :integer
#  people_type :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class StoryRelation < ActiveRecord::Base
  belongs_to :story
  belongs_to :people, polymorphic: true
end
