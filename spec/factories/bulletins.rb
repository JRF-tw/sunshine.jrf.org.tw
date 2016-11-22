# == Schema Information
#
# Table name: bulletins
#
#  id         :integer          not null, primary key
#  title      :string
#  content    :text
#  pic        :text
#  is_hidden  :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :bulletin do
    sequence(:title) { |n| "測試公告訊息-#{n}" }
    content '布拉不拉不拉'
    pic File.open "#{Rails.root}/spec/fixtures/person_avatar/people-2.jpg"
  end

end
