# == Schema Information
#
# Table name: lawyer_verdicts
#
#  id         :integer          not null, primary key
#  verdict_id :integer
#  lawyer_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :lawyer_verdict do
    lawyer { FactoryGirl.create :lawyer }
    verdict { FactoryGirl.create :verdict }
  end

end
