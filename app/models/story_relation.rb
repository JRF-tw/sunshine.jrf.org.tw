class StoryRelation < ActiveRecord::Base
  belongs_to :story
  belongs_to :people, polymorphic: true
end
