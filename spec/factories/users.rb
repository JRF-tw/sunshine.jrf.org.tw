# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  name                   :string(255)
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  admin                  :boolean          default(FALSE)
#

FactoryGirl.define do
  factory :user do
    name "5Fpro"
    sequence(:email) { |n| "user#{n}@5fpro.com" }
    password "12341234"
    confirmed_at Time.now

    factory :admin_user do
      admin true
    end

    factory :unconfirmed_user do
      confirmed_at nil
    end

    factory :creating_user do
      admin "0"
      confirmed_at nil
    end
  end
end
