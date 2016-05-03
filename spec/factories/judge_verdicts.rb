FactoryGirl.define do
  factory :judge_verdict do
    judge { FactoryGirl.create :judge }
    verdict { FactoryGirl.create :verdict }
  end

end
