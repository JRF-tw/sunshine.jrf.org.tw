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

  end

end
