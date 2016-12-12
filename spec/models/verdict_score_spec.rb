# == Schema Information
#
# Table name: verdict_scores
#
#  id                 :integer          not null, primary key
#  story_id           :integer
#  verdict_rater_id   :integer
#  verdict_rater_type :string
#  data               :hstore
#  appeal_judge       :boolean
#  status             :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  quality_scores     :hstore
#

require 'rails_helper'

RSpec.describe VerdictScore do
  let(:verdict_score) { create :verdict_score }

  describe 'FactoryGirl' do
    context 'normalize' do
      subject! { verdict_score }
      it { expect(subject).not_to be_new_record }
    end
  end
end
