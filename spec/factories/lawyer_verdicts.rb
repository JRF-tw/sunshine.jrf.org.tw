FactoryGirl.define do
  factory :lawyer_verdict do
    lawyer { FactoryGirl.create :lawyer }
    verdict { FactoryGirl.create :verdict }
  end

end
