# == Schema Information
#
# Table name: suit_banners
#
#  id         :integer          not null, primary key
#  pic_l      :string
#  pic_m      :string
#  pic_s      :string
#  url        :string
#  alt_string :string
#  title      :string
#  content    :text
#  weight     :integer
#  is_hidden  :boolean
#  created_at :datetime
#  updated_at :datetime
#

FactoryGirl.define do
  factory :suit_banner do
    pic_l File.open "#{Rails.root}/spec/fixtures/person_avatar/people-1.jpg"
    url "http://google.com"
    alt_string "haha"
    title "foofoo"
    content "foofoobarbarfoofoobarbarfoofoobarbarfoofoobarbar"
  end

end
