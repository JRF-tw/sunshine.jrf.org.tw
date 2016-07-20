require "rails_helper"

RSpec.describe Scrap::ImportScheduleContext, type: :model do
  let!(:court) { create :court, code: "TPH" }
  let!(:judge) { create :judge, court: court }
  let!(:branch) { create :branch, court: court, judge: judge, name: "平" }

  describe "#perform" do
    let(:hash_data) { { story_type: "民事", year: 105, word_type: "聲", number: "485", date: Time.zone.today, branch_name: "平", is_pronounce: false } }
    subject { described_class.new(court.code).perform(hash_data) }

    context "success" do
      it { expect { subject }.to change { Schedule.count } }
    end

    context "main_judge association" do
      context "not association to story" do
        it { expect(subject.story.main_judge).to be_nil }
      end

      context "normalize" do
        it { expect(subject.branch_judge).to eq(judge) }
      end

      context "mutiple branche" do
        let!(:judge1) { create :judge, court: court }
        let!(:branch1) { create :branch, court: court, judge: judge1, name: "平", chamber_name: "xxx法院民事庭" }
        it { expect(subject.branch_judge).to eq(judge1) }
      end

      context "not match judge" do
        before { branch.update_attributes(name: "x") }
        it { expect { subject }.to change_sidekiq_jobs_size_of(SlackService, :notify) }
      end
    end

    context "find story" do
      before { subject }
      it { expect { subject }.not_to change { Story.count } }
    end

    context "create story" do
      it { expect { subject }.to change { Story.count } }
    end

    context "update story is_pronounce" do
      let(:adjudged_data) { hash_data.merge(is_pronounce: true) }
      subject { described_class.new(court.code).perform(adjudged_data) }
      it { expect(subject.story.is_pronounce).to be_truthy }
    end

    context "update story pronounce date" do
      let(:pronounce_date) { hash_data.merge(is_pronounce: true, date: Time.zone.today) }
      subject { described_class.new(court.code).perform(pronounce_date) }

      context "pronounce_date nil" do
        it { expect(subject.story.pronounce_date).to be_truthy }
      end

      context "pronounce_date exist" do
        before { described_class.new(court.code).perform(pronounce_date) }

        it { expect { subject }.not_to change { subject.story.pronounce_date } }
      end
    end
  end
end
