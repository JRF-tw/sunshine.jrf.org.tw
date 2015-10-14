# == Schema Information
#
# Table name: courts
#
#  id         :integer          not null, primary key
#  court_type :string(255)
#  full_name  :string(255)
#  name       :string(255)
#  weight     :integer
#  created_at :datetime
#  updated_at :datetime
#  is_hidden  :boolean
#

FactoryGirl.define do
  factory :court do
    court_type "法院"
    full_name "‎臺灣新北地方法院"
    name "‎新北地院"
  end

end
