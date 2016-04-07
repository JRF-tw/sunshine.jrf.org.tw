# == Schema Information
#
# Table name: banners
#
#  id         :integer          not null, primary key
#  pic_l      :string
#  pic_m      :string
#  pic_s      :string
#  weight     :integer
#  is_hidden  :boolean
#  created_at :datetime
#  updated_at :datetime
#

FactoryGirl.define do
  factory :banner do
    pic_l File.open "#{Rails.root}/spec/fixtures/person_avatar/people-1.jpg"
  end

end
