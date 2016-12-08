# == Schema Information
#
# Table name: prosecutors_offices
#
#  id         :integer          not null, primary key
#  full_name  :string
#  name       :string
#  court_id   :integer
#  weight     :integer
#  is_hidden  :boolean          default(TRUE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :prosecutors_office do
    sequence(:full_name) { |n| "測試檢察署-#{n}" }
    sequence(:name) { |n| "測試地檢署-#{n}" }
    court { create(:court) }
    is_hidden false
    trait :without_full_name do
      full_name ''
    end
  end

  factory :prosecutors_office_for_params, class: ProsecutorsOffice do
    full_name '‎臺灣地方檢查署'
    name '‎臺地檢署'
    court_id { create(:court).id }
  end

  factory :prosecutors_office_without_court, class: ProsecutorsOffice do
    full_name '‎臺灣的地方檢查署'
    name '‎臺地的檢署'
  end

  factory :empty_full_name_for_prosecutors_office, class: ProsecutorsOffice do
    full_name '‎'
    name '‎臺地的檢署'
    court { create(:court) }
  end

end
