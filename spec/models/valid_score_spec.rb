# == Schema Information
#
# Table name: valid_scores
#
#  id               :integer          not null, primary key
#  story_id         :integer
#  judge_id         :integer
#  schedule_id      :integer
#  score_id         :integer
#  score_type       :string
#  score_rater_id   :integer
#  score_rater_type :string
#  attitude_scores  :hstore
#  command_scores   :hstore
#  quality_scores   :hstore
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'rails_helper'

RSpec.describe ValidScore do
  let(:valid_score) { create :valid_score }

  describe 'FactoryGirl' do
    context 'normalize' do
      subject! { valid_score }
      it { expect(subject).not_to be_new_record }
    end
  end
end
