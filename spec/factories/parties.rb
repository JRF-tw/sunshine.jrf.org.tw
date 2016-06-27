# == Schema Information
#
# Table name: parties
#
#  id                       :integer          not null, primary key
#  name                     :string           not null
#  identify_number          :string           not null
#  phone_number             :string
#  encrypted_password       :string           default(""), not null
#  reset_password_token     :string
#  reset_password_sent_at   :datetime
#  remember_created_at      :datetime
#  sign_in_count            :integer          default(0), not null
#  current_sign_in_at       :datetime
#  last_sign_in_at          :datetime
#  current_sign_in_ip       :string
#  last_sign_in_ip          :string
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  email                    :string
#  unconfirmed_email        :string
#  confirmed_at             :datetime
#  confirmation_token       :string
#  confirmation_sent_at     :datetime
#  phone_confirmed_at       :datetime
#  imposter                 :boolean          default(FALSE)
#  imposter_identify_number :string
#

#

FactoryGirl.define do
  factory :party do
    sequence(:name) { |n| "當事人 - #{n}"}
    password "12321313213"
    sequence(:identify_number) { |n| "A#{ rand(100000000..299999999) }" }
    sequence(:phone_number) { |n| "09#{ rand(1..99999999).to_s.rjust(8, '0') }" }

    trait :with_unconfirmed_email do
      unconfirmed_email "aron1122@gmail.com"
    end
  end

  factory :party_for_create, class: Party do
    sequence(:name) { |n| "當事人 - #{n}"}
    password "12321313213"
    password_confirmation "12321313213"
    sequence(:identify_number) { |n| "A#{ rand(100000000..299999999) }" }
    sequence(:phone_number) { |n| "09#{ rand(1..99999999).to_s.rjust(8, '0') }" }
  end
end
