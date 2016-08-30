# == Schema Information
#
# Table name: court_observers
#
#  id                     :integer          not null, primary key
#  name                   :string           not null
#  email                  :string           not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  phone_number           :string
#  school                 :string
#  student_number         :string
#  department_level       :string
#  last_scored_at         :date
#  subscribe_edm          :boolean          default(FALSE)
#

FactoryGirl.define do
  factory :court_observer do
    sequence(:name) { |n| "court_observer-#{n}" }
    sequence(:email) { |n| "court_observer-#{n}@test.com" }
    password "123123123"
    confirmed_at Time.now

    trait :with_unconfirmed_email do
      unconfirmed_email "aron1122@gmail.com"
    end

    trait :without_confirm do
      confirmed_at nil
    end

    trait :with_confirmation_token do
      confirmation_token "totoken"
    end
  end

  factory :court_observer_without_validate, class: CourtObserver do
    name "不理不理左衛門"
    sequence(:email) { |n| "court_observer_without_prove-#{n}@test.com" }
    password "123123123"
    confirmation_token "token"
  end

end
