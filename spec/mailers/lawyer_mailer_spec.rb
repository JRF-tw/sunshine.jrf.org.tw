require 'rails_helper'

RSpec.describe LawyerMailer, type: :mailer do
  let!(:story) { create :story, :with_schedule_date_today }
  let!(:lawyer) { create :lawyer }

  context '#story_before_judge_notice' do
    let(:mail) { described_class.story_before_judge_notice(story.id, lawyer.id).deliver_now }
    it { expect(mail.subject).to eq(story.detail_info + '開庭通知') }
    it { expect(mail.to).to eq([lawyer.email]) }
  end

  context '#story_after_judge_notice' do
    let(:mail) { described_class.story_after_judge_notice(story.id, lawyer.id).deliver_now }
    it { expect(mail.subject).to eq(story.detail_info + '開庭完畢，邀請您提供您的寶貴意見！') }
    it { expect(mail.to).to eq([lawyer.email]) }
  end

  context '#after_verdict_notice' do
    let!(:story) { create :story, :with_verdict, :adjudged }
    let(:mail) { described_class.after_verdict_notice(story.verdict.id, lawyer.id).deliver_now }
    it { expect(mail.subject).to eq(story.detail_info + '判決書已公開上網，邀請您提供您的寶貴意見！') }
    it { expect(mail.to).to eq([lawyer.email]) }
  end

  context '#active_verdict_notice' do
    let!(:story) { create :story, :with_verdict, :adjudged }
    let(:mail) { described_class.active_verdict_notice(story.verdict.id, lawyer.id).deliver_now }
    it { expect(mail.subject).to eq(story.detail_info + '判決書已經上網，邀請您給予寶貴的意見！') }
    it { expect(mail.to).to eq([lawyer.email]) }
  end
end
