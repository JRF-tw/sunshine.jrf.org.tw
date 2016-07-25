require "rails_helper"

RSpec.describe Story do
  let(:story) { create :story }

  describe "FactoryGirl" do
    describe "normalize" do
      subject! { story }
      it { expect(story).not_to be_new_record }
    end
  end

  context "#identity" do
    let(:story) { create :story, year: 100, word_type: "耶", number: 100 }
    it { expect(story.identity).to eq("100-耶-100") }
  end

  context "#by_relation_judges" do
    let(:judge) { create :judge }
    before { create :story_relation, story: story, people: judge }
    subject { story }

    it { expect(story.by_relation_judges.first.people).to eq(judge) }
  end

  context "#by_relation_lawyers" do
    let(:lawyer) { create :lawyer }
    before { create :story_relation, story: story, people: lawyer }
    subject { story }

    it { expect(story.by_relation_lawyers.first.people).to eq(lawyer) }
  end

  context "#by_relation_parties" do
    let(:party) { create :party }
    before { create :story_relation, story: story, people: party }
    subject { story }

    it { expect(story.by_relation_parties.first.people).to eq(party) }
  end
end
