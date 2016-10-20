# == Schema Information
#
# Table name: schedule_scores
#
#  id                  :integer          not null, primary key
#  schedule_id         :integer
#  judge_id            :integer
#  schedule_rater_id   :integer
#  schedule_rater_type :string
#  rating_score        :float
#  command_score       :float
#  attitude_score      :float
#  data                :hstore
#  appeal_judge        :boolean          default(FALSE)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  story_id            :integer
#

require "rails_helper"

RSpec.describe ScheduleScore do
  let(:schedule_score) { create :schedule_score }

  describe "FactoryGirl" do
    context "normalize" do
      subject! { schedule_score }
      it { expect(subject).not_to be_new_record }
    end
  end
end
