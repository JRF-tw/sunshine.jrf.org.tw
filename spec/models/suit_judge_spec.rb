# == Schema Information
#
# Table name: suit_judges
#
#  id         :integer          not null, primary key
#  suit_id    :integer
#  profile_id :integer
#  created_at :datetime
#  updated_at :datetime
#

require "rails_helper"

RSpec.describe SuitJudge, type: :model do

  it "has_many :suit_judges, dependent: :destroy" do
    suit_judge = create :suit_judge
    expect(SuitJudge.count).to eq(1)
    judge = suit_judge.judge
    judge.destroy
    expect(SuitJudge.count).to be_zero
  end
end
