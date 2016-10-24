# == Schema Information
#
# Table name: schedules
#
#  id              :integer          not null, primary key
#  story_id        :integer
#  court_id        :integer
#  branch_name     :string
#  start_on        :date
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  branch_judge_id :integer
#  courtroom       :string
#  start_at        :datetime
#

require 'rails_helper'

RSpec.describe Schedule do
  let(:schedule) { create :schedule }

  describe 'FactoryGirl' do
    context 'normalize' do
      subject! { schedule }
      it { expect(subject).not_to be_new_record }
    end

    context 'with branch judge' do
      let(:schedule) { create :schedule, :with_branch_judge }
      subject { schedule }
      it { expect(subject).not_to be_new_record }
    end
  end

  describe '#on_day' do
    let!(:schedule_date_tomorrow) { create :schedule, :date_is_tomorrow }
    it { expect(Schedule.on_day(Date.tomorrow).last).to eq(schedule_date_tomorrow) }
  end
end
