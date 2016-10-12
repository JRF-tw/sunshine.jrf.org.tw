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

require "rails_helper"

RSpec.describe StoryRelation, type: :model do
  describe "FactoryGirl" do
    describe "normalize" do
      let!(:story_relation) { create :story_relation }
      it { expect(story_relation).to be_present }
      it { expect(story_relation.people).to eq(Judge.last) }
    end
  end
end
