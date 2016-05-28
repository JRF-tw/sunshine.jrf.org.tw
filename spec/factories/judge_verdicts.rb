# == Schema Information
#
# Table name: judge_verdicts
#
#  id         :integer          not null, primary key
#  verdict_id :integer
#  judge_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :judge_verdict do
    judge { FactoryGirl.create :judge }
    verdict { FactoryGirl.create :verdict }
  end

end
