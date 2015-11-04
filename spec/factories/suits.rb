# == Schema Information
#
# Table name: suits
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  summary    :text
#  content    :text
#  state      :string(255)
#  pic        :string(255)
#  suit_no    :integer
#  keyword    :string(255)
#  created_at :datetime
#  updated_at :datetime
#  is_hidden  :boolean
#

FactoryGirl.define do
  factory :suit do
    title "foobar"
    suit_no 123
    state "處理中"
    summary "foooofooooofooooo"
    content "barrrrbaaar"
  end

end
