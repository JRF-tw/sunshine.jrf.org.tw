FactoryGirl.define do
  factory :story_relation do
    story { FactoryGirl.create :story }
    people { FactoryGirl.create :judge }
  end

end
