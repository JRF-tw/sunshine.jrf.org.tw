# == Schema Information
#
# Table name: judges
#
#  id                 :integer          not null, primary key
#  name               :string
#  current_court_id   :integer
#  avatar             :string
#  gender             :string
#  gender_source      :string
#  birth_year         :integer
#  birth_year_source  :string
#  stage              :integer
#  stage_source       :string
#  appointment        :string
#  appointment_source :string
#  memo               :string
#  is_active          :boolean
#  is_hidden          :boolean
#  punishments_count  :integer          default(0)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

FactoryGirl.define do
  factory :judge do
    name "Raptor Judge"

    trait :with_avatar do
      avatar File.open "#{Rails.root}/spec/fixtures/person_avatar/people-1.jpg"
    end
  end
end
