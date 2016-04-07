# == Schema Information
#
# Table name: branches
#
#  id           :integer          not null, primary key
#  court_id     :integer
#  judge_id     :integer
#  name         :string
#  chamber_name :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

FactoryGirl.define do
  factory :branch do
    sequence(:name) { |n| "branch_name-#{n}" }
    sequence(:chamber_name) { |n| "chamber_name-#{n}" }
  end

end
