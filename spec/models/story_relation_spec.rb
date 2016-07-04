require 'rails_helper'

RSpec.describe StoryRelation, type: :model do
  describe "FactoryGirl" do
    describe "normalize" do
      let!(:story_relation) { FactoryGirl.create :story_relation }
      it { expect(story_relation).to be_present }
      it { expect(story_relation.people).to eq(Judge.last) }
    end
  end
end
