require 'rails_helper'

RSpec.describe MailerPresenters do
  let!(:story) { create :story, :with_schedule_date_tomorrow }

  describe '#remind_story_before_judge' do
    let(:date) { story.schedules.last.start_at }
    let(:wording) { "您於司法陽光網訂閱#{story.detail_info}，該案即將於#{date.year}年#{date.mon}月#{date.mday}日#{date.hour}點#{date.min}分於#{story.court.full_name}#{story.story_type}#{story.schedules.last.courtroom}開庭，請記得寫上您的行事曆喔！" }
    subject { described_class.new.remind_story_before_judge(story) }
    it { expect(subject).to eq(wording) }
  end

  describe '#google_calendar_link' do
    let(:datetime) { story.schedules.last.start_at }
    let(:wording) { "https://www.google.com/calendar/render?action=TEMPLATE&trp=true&sf=true&output=xml&dates=#{datetime.strftime('%Y%m%d')}T#{datetime.strftime('%H%M') + '00'}Z/#{datetime.strftime('%Y%m%d')}T#{(datetime + 10_800).strftime('%H%M') + '00'}Z&text=#{story.detail_info}案件開庭" }
    subject { described_class.new.google_calendar_link(story) }
    it { expect(subject).to eq(wording) }
  end
end
