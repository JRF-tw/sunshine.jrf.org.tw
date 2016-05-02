require 'rails_helper'

RSpec.describe Scrap::ImportScheduleContext, :type => :model do
  let!(:court) { FactoryGirl.create :court, code: "TPH" }
  let!(:judge) { FactoryGirl.create :judge, court: court }
  let!(:branch) { FactoryGirl.create :branch, court: court, judge: judge, name: "平" }

  describe "#perform" do
    let(:hash_data) { { story_type: "民事", year: 105, word_type: "聲", number: "485", date: Date.today, branch_name: "平", is_adjudge: false} }
    subject{ described_class.new(court).perform(hash_data) }

    context "success" do
      it { expect{ subject }.to change{ Schedule.count } }
    end

    context "get main judge" do
      it { expect(subject.story.main_judge).to eq(judge) }

      context "mutiple branche" do
        let!(:judge1) { FactoryGirl.create :judge, court: court }
        let!(:branch1) { FactoryGirl.create :branch, court: court, judge: judge1, name: "平", chamber_name: "xxx法院民事庭" }
        it { expect(subject.story.main_judge).to eq(judge1) }
      end

      context "not match judge" do
        it { expect{ subject }.to change_sidekiq_jobs_size_of(SlackService, :notify) }
      end
    end

    context "find story" do
      before { subject }
      it { expect{ subject }.not_to change{ Story.count } }
    end

    context "create story" do
      it { expect{ subject }.to change{ Story.count } }
    end

    context "update story is_adjudge" do
      let(:adjudged_data) { hash_data.merge(is_adjudge: true) }
      subject{ described_class.new(court).perform(adjudged_data) }
      it { expect(subject.story.is_adjudge).to be_truthy }
    end
  end
end
