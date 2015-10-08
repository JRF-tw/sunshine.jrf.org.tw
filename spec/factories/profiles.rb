# == Schema Information
#
# Table name: profiles
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  current            :string(255)
#  avatar             :string(255)
#  gender             :string(255)
#  gender_source      :string(255)
#  birth_year         :integer
#  birth_year_source  :string(255)
#  stage              :integer
#  stage_source       :string(255)
#  appointment        :string(255)
#  appointment_source :string(255)
#  memo               :text
#  created_at         :datetime
#  updated_at         :datetime
#  current_court      :string(255)
#  is_active          :boolean
#

FactoryGirl.define do
  factory :profile do
    name "Dahlia"
    current "法官"
    gender "女"
    factory :judge_profile do
      current "法官"
    end
    factory :prosecutor_profile do
      current "檢察官"
    end
    factory :profile_had_avatar do
      avatar File.open "#{Rails.root}/spec/fixtures/person_avatar/people-1.jpg"
    end
  end
end
