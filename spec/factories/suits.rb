# == Schema Information
#
# Table name: suits
#
#  id              :integer          not null, primary key
#  title           :string
#  summary         :text
#  content         :text
#  state           :string
#  pic             :string
#  suit_no         :integer
#  keyword         :string
#  created_at      :datetime
#  updated_at      :datetime
#  is_hidden       :boolean
#  procedure_count :integer          default(0)
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
