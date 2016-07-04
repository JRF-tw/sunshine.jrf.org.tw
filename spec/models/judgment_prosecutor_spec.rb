# == Schema Information
#
# Table name: judgment_prosecutors
#
#  id          :integer          not null, primary key
#  profile_id  :integer
#  judgment_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#

require "rails_helper"

RSpec.describe JudgmentProsecutor, type: :model do

  it "has_many :judgment_judges, dependent: :destroy" do
    judgment_prosecutor = FactoryGirl.create :judgment_prosecutor
    expect(JudgmentProsecutor.count).to eq(1)
    judgment = judgment_prosecutor.judgment
    judgment.destroy
    expect(JudgmentProsecutor.count).to be_zero
  end

end
