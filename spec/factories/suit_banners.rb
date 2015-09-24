# == Schema Information
#
# Table name: suit_banners
#
#  id         :integer          not null, primary key
#  pic_l      :string(255)
#  pic_m      :string(255)
#  pic_s      :string(255)
#  url        :string(255)
#  alt_string :string(255)
#  title      :string(255)
#  content    :string(255)
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
