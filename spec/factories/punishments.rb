FactoryGirl.define do
  factory :punishment do
    profile do
      FactoryGirl.create :profile
    end
    decision_unit 'foo'
  end

end
