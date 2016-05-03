# == Schema Information
#
# Table name: defendant_verdicts
#
#  id           :integer          not null, primary key
#  verdict_id   :integer
#  defendant_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

FactoryGirl.define do
  factory :defendant_verdict do
    defendant { FactoryGirl.create :defendant }
    verdict { FactoryGirl.create :verdict }
  end

end
