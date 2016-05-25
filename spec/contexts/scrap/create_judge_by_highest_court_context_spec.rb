require 'rails_helper'

RSpec.describe Scrap::CreateJudgeByHighestCourtContext, :type => :model do
  describe "#perform" do
    let!(:court) { FactoryGirl.create :court, code: "TPS", scrap_name: "最高法院" }
    let!(:court1) { FactoryGirl.create :court, code: "TPX", scrap_name: "OOOOOOO" }
    let!(:name) { "xxx" }
    subject{ described_class.new(court, name).perform }

    describe "#is_highest_court?" do
      context "is highest" do
        subject{ described_class.new(court, name).perform }
        it { expect(subject).to be_truthy }
      end

      context "not highest" do
        subject{ described_class.new(court1, name).perform }
        it { expect(subject).to be_falsey }
        it { expect{ subject }.not_to change { Judge.count } }
      end
    end

    context "already has judge" do
      let!(:judge) { FactoryGirl.create :judge, name: "xxx", court: court }

      it { expect{ subject }.not_to change { Judge.count } }
    end

    context "create new judge" do
      it { expect{ subject }.to change { Judge.count } }
    end

    describe "#notify" do
      context "new record" do
        it { expect{ subject }.to change_sidekiq_jobs_size_of(SlackService, :notify) }
      end

      context "new record" do
        let!(:judge) { FactoryGirl.create :judge, name: "xxx", court: court }
        it { expect{ subject }.not_to change_sidekiq_jobs_size_of(SlackService, :notify) }
      end
    end
  end
end
