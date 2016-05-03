FactoryGirl.define do
  factory :defendant_verdict do
    defendant { FactoryGirl.create :defendant }
    verdict { FactoryGirl.create :verdict }
  end

end
