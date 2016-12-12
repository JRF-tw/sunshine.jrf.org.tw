# == Schema Information
#
# Table name: schedule_scores
#
#  id                  :integer          not null, primary key
#  schedule_id         :integer
#  judge_id            :integer
#  schedule_rater_id   :integer
#  schedule_rater_type :string
#  data                :hstore
#  appeal_judge        :boolean          default(FALSE)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  story_id            :integer
#  attitude_scores     :hstore
#  command_scores      :hstore
#

require 'rails_helper'

RSpec.describe ScheduleScore do
  let(:schedule_score) { create :schedule_score }

  describe 'FactoryGirl' do
    context 'normalize' do
      subject! { schedule_score }
      it { expect(subject).not_to be_new_record }
    end
  end
end
