# == Schema Information
#
# Table name: banners
#
#  id         :integer          not null, primary key
#  pic_l      :string(255)
#  pic_m      :string(255)
#  pic_s      :string(255)
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
