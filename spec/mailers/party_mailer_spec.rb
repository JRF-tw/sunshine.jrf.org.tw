require "rails_helper"

RSpec.describe PartyMailer, type: :mailer do
  let!(:story) { FactoryGirl.create :story }
  let!(:party) { FactoryGirl.create :party }

  context "#story_before_judge_notice" do
    let(:mail) { described_class.story_before_judge_notice(story.id, party.id).deliver_now }
    it { expect(mail.subject).to eq('開庭通知') }
    it { expect(mail.to).to eq([party.email]) }
  end

  context "#story_after_judge_notice" do
    let(:mail) { described_class.story_after_judge_notice(story.id, party.id).deliver_now }
    it { expect(mail.subject).to eq('評鑑通知') }
    it { expect(mail.to).to eq([party.email]) }
  end
end
