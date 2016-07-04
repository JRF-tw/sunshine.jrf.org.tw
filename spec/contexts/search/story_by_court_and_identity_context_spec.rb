require "rails_helper"

describe Search::StoryByCourtAndIdentityContext do
  let!(:court) { FactoryGirl.create :court, full_name: "測試法院" }
  let!(:story) { FactoryGirl.create :story, court: court, year: 105, word_type: "聲", number: 111 }

  describe "#perform" do
    subject { described_class.new(court.full_name, story.year, story.word_type, story.number) }

    it { expect(subject.perform).to eq(story) }
  end

  context "not find court" do
    subject { described_class.new("xxx", story.year, story.word_type, story.number) }
    before { subject.perform }

    it { expect(subject.has_error?).to be_truthy }
  end

  context "identity not found" do
    subject { described_class.new(court.full_name, "xxx", story.word_type, story.number) }

    it { expect(subject.perform).to be_nil }
  end
end
