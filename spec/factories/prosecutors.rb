# == Schema Information
#
# Table name: prosecutors
#
#  id                    :integer          not null, primary key
#  name                  :string
#  prosecutors_office_id :integer
#  judge_id              :integer
#  avatar                :string
#  gender                :string
#  gender_source         :string
#  birth_year            :integer
#  birth_year_source     :string
#  stage                 :integer
#  stage_source          :string
#  appointment           :string
#  appointment_source    :string
#  memo                  :string
#  is_active             :boolean          default(TRUE)
#  is_hidden             :boolean          default(TRUE)
#  is_judge              :boolean          default(FALSE)
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  punishments_count     :integer          default(0)
#

FactoryGirl.define do
  factory :prosecutor do
    sequence(:name) { |n| "Raptor prosecutor-#{n}" }
    prosecutors_office { create :prosecutors_office }
    is_hidden false
    trait :with_avatar do
      avatar File.open "#{Rails.root}/spec/fixtures/person_avatar/people-1.jpg"
    end
  end

  factory :admin_prosecutor, class: Admin::Prosecutor do |_f|
    sequence(:name) { |n| "Raptor prosecutor-#{n}" }
    prosecutors_office { create :prosecutors_office }
    is_hidden false
    trait :with_avatar do
      avatar File.open "#{Rails.root}/spec/fixtures/person_avatar/people-1.jpg"
    end
  end

  factory :prosecutor_for_params, class: Prosecutor do
    name '不理不理右衛門'
    prosecutors_office_id { (create :prosecutors_office).id }
  end

  factory :empty_name_for_prosecutor, class: Prosecutor do
    name ''
  end

end
