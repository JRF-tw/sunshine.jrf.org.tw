# == Schema Information
#
# Table name: verdicts
#
#  id         :integer          not null, primary key
#  story_id   :integer
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :verdict do
    content "blablabla"
  end

end
