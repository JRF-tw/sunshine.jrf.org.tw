require 'rails_helper'

RSpec.describe LawyerMailer, type: :mailer do
  let!(:story) { create :story, :with_schedule_date_today }
  let!(:lawyer) { create :lawyer }

  context '#story_before_judge_notice' do
    let(:mail) { described_class.story_before_judge_notice(story.id, lawyer.id).deliver_now }
    it { expect(mail.subject).to eq("#{story.court.full_name}#{story.year}年#{story.word_type}字第#{story.number}號開庭通知") }
    it { expect(mail.to).to eq([lawyer.email]) }
  end

  context '#story_after_judge_notice' do
    let(:mail) { described_class.story_after_judge_notice(story.id, lawyer.id).deliver_now }
    it { expect(mail.subject).to eq("#{story.court.full_name}#{story.year}年#{story.word_type}字第#{story.number}號開庭完畢，邀請您提供您的寶貴意見！") }
    it { expect(mail.to).to eq([lawyer.email]) }
  end

  context '#story_after_verdict_notice' do
    let!(:story) { create :story, :with_adjugde_verdict, :adjudged }
    let(:mail) { described_class.story_after_verdict_notice(story.id, lawyer.id).deliver_now }
    it { expect(mail.subject).to eq("#{story.court.full_name}#{story.year}年#{story.word_type}字第#{story.number}號案件已判決，邀請您提供您的寶貴意見！") }
    it { expect(mail.to).to eq([lawyer.email]) }
  end
end
