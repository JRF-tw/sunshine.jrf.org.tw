# == Schema Information
#
# Table name: banners
#
#  id          :integer          not null, primary key
#  weight      :integer
#  is_hidden   :boolean
#  created_at  :datetime
#  updated_at  :datetime
#  title       :string
#  link        :string
#  btn_wording :string
#  pic         :string
#  desc        :string
#

FactoryGirl.define do
  factory :banner do
    title '標題一號'
    link 'http//example.com'
    pic Rack::Test::UploadedFile.new("#{Rails.root}/spec/fixtures/person_avatar/people-1.jpg")
  end

end
