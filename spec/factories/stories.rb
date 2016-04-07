# == Schema Information
#
# Table name: stories
#
#  id            :integer          not null, primary key
#  court_id      :integer
#  main_judge_id :integer
#  type          :string
#  year          :integer
#  word_type     :string
#  number        :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

FactoryGirl.define do
  factory :story do
    type "民事"
    year { rand(70..105) }
    word_type "聲"
    number { rand(100..999) }
  end

end
