# == Schema Information
#
# Table name: judgment_judges
#
#  id          :integer          not null, primary key
#  profile_id  :integer
#  judgment_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#

require 'rails_helper'

RSpec.describe JudgmentJudge, type: :model do
  
  it "has_many :judgment_judges, dependent: :destroy" do
    judgment_judge = FactoryGirl.create :judgment_judge
    expect(JudgmentJudge.count).to eq(1)
    judgment = judgment_judge.judgment
    judgment.destroy
    expect(JudgmentJudge.count).to be_zero
  end

end
